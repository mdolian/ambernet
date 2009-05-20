$(function() {
  jQuery(document).ready(function($) {
	  $("div[id*='dialog_setlist']").dialog({ autoOpen: false, width: 400, modal: true });
	  $("div[id*='dialog_rec']").dialog({ autoOpen: false, width: 400, modal: true });		
		$.fn.setlist = function(show_id){
			that = this
			var set = new Array();
			$.getJSON("/shows/setlist/" + show_id, function(json){
				set[1] = "<b>Set 1:</b> "
				set[2] = "<b>Set 2:</b> "
				set[3] = "<b>Set 3:</b> "
				set[4] = "<b>Set 4:</b> "
				set[5] = "<b>Set 5:</b> "												
				set[9] = "<b>Encore:</b> "
				total_sets = 0		
				$.each(json, function(i, item) {
					total_sets = item.total_sets
					set[item.set_id] += item.song_name + item.segue;
				});
				html = "<p>"
				for(i=1; i<=total_sets; i++) {
					html += set[i] + "<br/>"
				}
				if(set[9] != "<b>Encore:</b> ") {
				  html += set[9]
				}
				html += "</p>";
			  $(that).html(html);
			  $(that).dialog("open");
			});								
		}
		$.fn.recordings = function(show_id){
			that = this; 
		  $.ajax({
			  url:  "/shows/recordings/" + show_id,
			  success: function(msg) {
				  $(that).html(msg);
				  $(that).dialog("open");
			  }	
		  })						
		}
		$.fn.details = function(show_id){
		  $("div[id*='dialog_rec']").dialog('close');			
		  $.ajax({
			  url:  "/recordings/show/" + show_id,
			  success: function(msg) {
				  $('#main_shows').html(msg);
			  }	
		  })						
		}		
  });	
});		