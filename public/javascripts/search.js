$(function() {
  jQuery(document).ready(function($) {
		$("#venue_name").autoSuggest("/venues/list");
		$("#venue_city").autoSuggest("/venues/city_list");	
		$("#browse").tabs();
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