<?php
namespace wcf\system\search;
use wcf\data\object\type\ObjectTypeCache;
use wcf\system\exception\SystemException;
use wcf\system\SingletonFactory;
use wcf\system\WCF;

/**
 * Manages the search index.
 *
 * @author	Marcel Werk
 * @copyright	2001-2012 WoltLab GmbH
 * @license	GNU Lesser General Public License <http://opensource.org/licenses/lgpl-license.php>
 * @package	com.woltlab.wcf.search
 * @subpackage	system.search
 * @category 	Community Framework
 */
class SearchIndexManager extends SingletonFactory {
	/**
	 * list of available object types
	 * @var array
	 */
	protected $availableObjectTypes = array();
	
	/**
	 * @see wcf\system\SingletonFactory::init()
	 */
	protected function init() {
		// get available object types
		$this->availableObjectTypes = ObjectTypeCache::getInstance()->getObjectTypes('com.woltlab.wcf.searchableObjectType');
	}

	/**
	 * Gets the object type id.
	 * 
	 * @param	string 		$objectType
	 * @return	integer
	 */
	public function getObjectTypeID($objectType) {
		if (!isset($this->availableObjectTypes[$objectType])) {
			throw new SystemException("unknown object type '".$objectType."'");
		}

		return $this->availableObjectTypes[$objectType]->objectTypeID;
	}
	
	/**
	 * Adds a new entry.
	 *
	 * @param	string		$objectType
	 * @param	integer		$objectID
	 * @param	string		$message
	 * @param	string		$subject
	 * @param	integer		$time
	 * @param	integer		$userID
	 * @param	string		$username
	 * @param	string		$metaData
	 */
	public function add($objectType, $objectID, $message, $subject, $time, $userID, $username, $metaData = '') {
		// save new entry
		$sql = "INSERT INTO	wcf".WCF_N."_search_index
					(objectTypeID, objectID, subject, message, time, userID, username, metaData)
			VALUES		(?, ?, ?, ?, ?, ?, ?, ?)";
		$statement = WCF::getDB()->prepareStatement($sql);
		$statement->execute(array($this->getObjectTypeID($objectType), $objectID, $subject, $message, $time, $userID, $username, $metaData));
	}
	
	/**
	 * Updates the search index.
	 * 
	 * @param	string		$objectType
	 * @param	integer		$objectID
	 * @param	string		$message
	 * @param	string		$subject
	 * @param	integer		$time
	 * @param	integer		$userID
	 * @param	string		$username
	 * @param	string		$metaData
	 */
	public function update($objectType, $objectID, $message, $subject, $time, $userID, $username, $metaData = '') {
		// delete existing entry
		$this->delete($objectType, array($objectID));
		
		// save new entry
		$this->add($objectType, $objectID, $message, $subject, $time, $userID, $username, $metaData);
	}
	
	/**
	 * Deletes search index entries.
	 * 
	 * @param	string		$objectType
	 * @param	array<integer>	$objectIDs
	 */
	public function delete($objectType, array $objectIDs) {
		$objectTypeID = $this->getObjectTypeID($objectType);
		
		$sql = "DELETE FROM	wcf".WCF_N."_search_index
			WHERE		objectTypeID = ?
					AND objectID = ?";
		$statement = WCF::getDB()->prepareStatement($sql);
		WCF::getDB()->beginTransaction();
		foreach ($objectIDs as $objectID) {
			$statement->execute(array($objectTypeID, $objectID));
		}
		WCF::getDB()->commitTransaction();
	}
}