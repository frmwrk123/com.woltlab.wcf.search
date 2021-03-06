{capture assign='__searchFormLink'}{link controller='Search'}{/link}{/capture}
{capture assign='__searchInputPlaceholder'}{lang}wcf.global.search.enterSearchTerm{/lang}{/capture}
{capture assign='__searchDropdownOptions'}<label><input type="checkbox" name="subjectOnly" value="1" /> {lang}wcf.search.subjectOnly{/lang}</label>{/capture}
{assign var='__searchHiddenInputFields' value=''}

{event name='settings'}

<aside id="search" class="searchBar dropdown">
	<form method="post" action="{@$__searchFormLink}">
		<input type="search" name="q" placeholder="{@$__searchInputPlaceholder}" autocomplete="off" required="required" value="" class="dropdownToggle" data-toggle="search" />
		
		<ul class="dropdownMenu">
			{hascontent}
				<li class="dropdownText">
					{content}
						{@$__searchDropdownOptions}
					{/content}
				</li>
				<li class="dropdownDivider"></li>
			{/hascontent}
			<li><a href="{@$__searchFormLink}">{lang}wcf.search.extended{/lang}</a></li>
		</ul>
		
		{@$__searchHiddenInputFields}
	</form>
</aside>

<script type="text/javascript" src="{@$__wcf->getPath('wcf')}js/WCF.Search.Message.js?t={@TIME_NOW}"></script>
<script type="text/javascript">
	//<![CDATA[
	$(function() {
		new WCF.Search.Message.SearchArea($('#search'));
	});
	//]]>
</script>