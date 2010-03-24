$(function() {
  jQuery(document).ready(function($) {
  	$("#nav ul li a").corner();

		$("div[id*='accordion']").accordion({
			autoHeight: false, 
			collapsible: true
		});
		
		$("#venue_name").autoSuggest("/venues/list", {
			selectedItemProp: "label",
			selectedValuesProp: "id",
			searchObjProps: "label"
		});

		$("#venue_city").autoSuggest("/venues/city_list", {
			selectedItemProp: "label",
			selectedValuesProp: "label",
			searchObjProps: "label"
		});

		$("button, input:button, a", ".wizard").button();
		$("a", ".wizard").click(function() { return false; });

		$("#browseForm").formwizard({ 
			validationEnabled : true,
			focusFirstInput : true
		});
  });	
});