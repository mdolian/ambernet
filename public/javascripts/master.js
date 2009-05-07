$(function() {
  jQuery(document).ready(function($) {	
	  $("#index_tabs").tabs({
			ajaxOptions: { 
				async: false,
				beforeSend: function() {
					$("div[id*='main']").html('<p align="center"><br><br><br><br><br><img src="/images/loading_bar.gif" width="220" height="19" /><br><br><br><br><br></p>');
				},
			}			
		});
		$("table").tablesorter({widthFixed: true, widgets: ['zebra']});	
  });		
});