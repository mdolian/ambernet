$(function() {
  jQuery(document).ready(function($) {
		$("#browseForm").formwizard();
		
		$('.navigation_button').bind('click', function() {
			browse = $('input[name=browse]:checked').val()
			
			if(browse == 'shows') {
				text = "Confirm your list of songs: "
				
			}
			
		});		
		
	});
});