$(function() {
  jQuery(document).ready(function($) {	
		$("div[id*='search_accordion']").accordion({
			autoHeight: false, 
			collapsible: true
		});
		$("#venue_name").autocomplete("/venues/list");
		$("#venue_city").autocomplete("/venues/city_list");	
		$('#start_date').datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true	
		});	
		$('#end_date').datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true
		});
  });		
});