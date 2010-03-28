$(function() {
  jQuery(document).ready(function($) {
		$("#browseForm").formwizard();
		
		$('.navigation_button').bind('click', function() {
			alert($('input[name=browse]:checked').val() );
		});		
		
	});
});