$(function() {
  jQuery(document).ready(function($) {
	  $("a[id*='recording_details_shows']").livequery('click', function() {
			$("div[id*='dialog_rec']").dialog('close');
			$("div[id*='dialog_setlist']").dialog('close');	
			displayLoadingImage();	
		  $.ajax({
			  url:  this.href,
			  success: function(msg) {
				  $('#search_accordion_shows').html(msg);
			  }	
		  })	   
	    return false;
	  });	
	  $("a[id*='recording_details_rec']").livequery('click', function() {
			displayLoadingImage('recordings');
		  $.ajax({
			  url:  this.href,
			  success: function(msg) {
				  $('#main_recordings').html(msg);
			  }	
		  })		
	    return false;
	  });	
	  $('div.paginated a').livequery('click', function() {
			displayLoadingImage('recordings');
		  $.ajax({
			  url:  this.href,
			  success: function(msg) {
				  $('#main_recordings').html(msg);
			  }	
		  })
	    return false;
	  });	
		$(".reload_recording").livequery('click', function() {
			displayLoadingImage();
		  $.ajax({
			  url:  this.href,
			  success: function(msg) {
				  $('#main_recordings').html(msg);
			  }	
		  })		
		  return false;
		});		
	  $('.back_shows').livequery('click', function() {
			$('#main_shows').html('<p><br><br><br><br><br><img src="/images/loading_bar.gif" width="220" height="19" /><br><br><br><br><br></p>');
		  $.ajax({
			  url:  this.href,
			  success: function(msg) {
				  $('#main_shows').html(msg);
			  }	
		  })		
	    return false;
	  });
	  $('.back_recordings').livequery('click', function() {
			$('#main_recordings').html('<p><br><br><br><br><br><img src="/images/loading_bar.gif" width="220" height="19" /><br><br><br><br><br></p>');
		  $.ajax({
			  url:  this.href,
			  success: function(msg) {
				  $('#main_recordings').html(msg);
			  }	
		  })		
	    return false;
	  });		
	  $("#index_tabs").tabs({
			ajaxOptions: { 
				async: false,
				beforeSend: function() {
					$("div[id*='main_']").html('<p align="center"><br><br><br><br><br><img src="/images/loading_bar.gif" width="220" height="19" /><br><br><br><br><br></p>');
				},
			}			
		});		
		$("#index_tabs").tabs('load', 1);
		$("#index_tabs").tabs('load', 2);	
		$("#index_tabs").tabs('load', 3);	
		$("#index_tabs").tabs('load', 0);				
		$("table").tablesorter({widthFixed: true, widgets: ['zebra']});	
		$("#image_anchor").fancybox();
		$('#zip_link_mp3').livequery('click', function() {
			$('#zip_mp3').html("<img src='/images/loading.gif'/><br><div id='status_mp3'></div>")
		  $.ajax({
				url: '/recordings/zip/' + $('#recording_id').html()  + '/mp3',
				success: function(msg) {
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
	function displayLoadingImage(tab) {
		$('#main_' + tab).html('<p><br><br><br><br><br><img src="/images/loading_bar.gif" width="220" height="19" /><br><br><br><br><br></p>');
	}	
});