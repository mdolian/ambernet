$(function() {
  jQuery(document).ready(function($) {
	  $("div[id*='dialog_setlist']").dialog({ autoOpen: false });
	  $("div[id*='dialog_rec']").dialog({ autoOpen: false });	
		$("table") 
		  .tablesorter({widthFixed: true, widgets: ['zebra']});		
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
				html = "<font size'1'>"
				for(i=1; i<=total_sets; i++) {
					html += set[i] + "<br/>"
				}
				html += set[9]
				html += "</font>";
			  $(that).html(html);
			  $(that).dialog("open");
			});								
		}
		$.fn.recordings = function(show_id){
			that = this; 
			$.getJSON("/shows/recordings/" + show_id, function(json){
				html = "<table><tr><th>Label</th><th>Taper</th><th>Source</th></tr>";
				$.each(json, function(i, item) {
					html += "<td><a href='/recordings/show/" + item.id + "'>" + item.label + "</td>";
					html += "<td>" + item.taper + "</td>";
					html += "<td>" + item.source + "</td>";	
				});
			  $(that).html(html);
			  $(that).dialog("open");
			});							
		}
  });		
});		