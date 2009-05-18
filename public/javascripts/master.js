$(function() {
  jQuery(document).ready(function($) {	
	  $("#index_tabs").tabs({
			ajaxOptions: { 
				async: false,
				beforeSend: function() {
					$("div[id*='main_']").html('<p align="center"><br><br><br><br><br><img src="/images/loading_bar.gif" width="220" height="19" /><br><br><br><br><br></p>');
				},
			}			
		});
		$("table").tablesorter({widthFixed: true, widgets: ['zebra']});	
		$("#image_anchor").fancybox();
		$('#zip_link_mp3').livequery('click', function() {
			$('#zip_mp3').html("<img src='/images/loading.gif'/><br><div id='status_mp3'></div>")
		  $.ajax({
				url: '/recordings/zip/' + $('#recording_id').html()  + '/mp3',
				success: function(msg) {
					$('#zip_mp3').html(msg);
					var m = setInterval(function() {
				     $('#zip_mp3').load('/recordings/zip_link/' + $('#recording_id').html() + '/mp3');
				     if($('#status_mp3').html() == null || $('#status_mp3').html() == "") {
					   } else {
							 clearInterval(m);			
				     }
				  }, 30000);				
				}			
			})
		  return false;
		});	
		$('#zip_link_lossless').livequery('click', function() {
			$('#zip_lossless').html("<img src='/images/loading.gif'/><br><div id='status_lossless'></div>")			
		  $.ajax({
				url: '/recordings/zip/' + $('#recording_id').html()  + '/lossless',
				success: function(msg) {
					$('#zip_lossless').html(msg);
					var l = setInterval(function() {
				     $('#zip_lossless').load('/recordings/zip_link/' + $('#recording_id').html() + '/lossless');
				     if($('#status_lossless').html() == null || $('#status_lossless').html() == "") {
					   } else {
							 clearInterval(l);			
				     }		  
				  }, 60000);				
				}
			})
		  return false;
		});		
  });		
});