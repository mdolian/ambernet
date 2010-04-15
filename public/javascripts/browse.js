$(function() {
  jQuery(document).ready(function($) {
		$("#browseForm").formwizard();
		
		$('.navigation_button').bind('click', function() {
			branch = $('input[name=browse]:checked').val()
			switch(branch) {
				case "song":
					alert("songs");
					break;
				case "date":
					alert("date");
					break;
				case "venue":
					alert("venue");
					break;
				case "recording_type":
					alert("recording type");
					break;
			}
		});		
		
	});
});