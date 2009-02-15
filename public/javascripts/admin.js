$(function() {
  jQuery(document).ready(function($) {	
		$('#show_date_played').datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,	
			showOn: 'button', 
			buttonImage: '../images/calendar.gif', 
			buttonImageOnly: true,		
			onSelect: function(){
				$.getJSON("/shows/list", {date_played: $('#show_date_played').val()}, function(json){
					html = "";
					$.each(json, function(i, item) {
					  html += "<a href='#' id='show_link' onclick='$(this).select_show(" + item.id + ")'>";
					  html += item.label;
					  html += "</a>";
					});
					$("#dialog").dialog();
					$("#dialog").html(html);
				});			
			}
		});	
    $.fn.select_show = function(show_id){
	    $("#dialog").dialog("close");
	    $("#show_id").val(show_id);
		}								
  });		
});