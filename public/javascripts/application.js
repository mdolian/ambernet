$(function() {
  jQuery(document).ready(function($) {					
		$("table").tablesorter({widthFixed: true, widgets: ['zebra']});	
		$("#image_anchor").fancybox();		
  });
	function displayLoadingImage(tab) {
		$('#main_' + tab).html('<p><br><br><br><br><br><img src="/images/loading_bar.gif" width="220" height="19" /><br><br><br><br><br></p>');
	}	
});