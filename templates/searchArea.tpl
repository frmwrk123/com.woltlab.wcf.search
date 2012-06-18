<aside id="search" class="searchBar dropdown">
	<form method="post" action="{link controller='Search'}{/link}">
		<input type="search" name="q" placeholder="{lang}wcf.global.search.enterSearchTerm{/lang}" value="" class="dropdownToggle" data-toggle="search" />
	
		<ul class="dropdownMenu">
			<li class="dropdownText">
				<label><input type="checkbox" name="subjectOnly" value="1" /> {lang}wcf.search.subjectOnly{/lang}</label>
				{event name='searchDropdownOptions'}
			</li>
			<li class="dropdownDivider"></li>
			<li><a href="{link controller='Search'}{/link}">wcf.search.extended</a></li>
		</ul>
	</form>
</aside>

<script type="text/javascript" src="{@$__wcf->getPath('wcf')}js/WCF.Search.Message.js"></script>
<script type="text/javascript">
	//<![CDATA[
	$(function() {
		new WCF.Search.Message.SearchArea($('#search'));
	});
	//]]>
</script>