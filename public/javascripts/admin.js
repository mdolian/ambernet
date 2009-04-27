$(function() {
  jQuery(document).ready(function($) {	
    $('#delete').confirm({
	  	eventType:'mouseover',
	    timeout:3000,
		  dialogShow:'fadeIn',
		  dialogSpeed:'slow'});	
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
					$("#dialog").html(html);
					$("#dialog").dialog();
				});			
			}
		});	
    $.fn.select_show = function(show_id){
	    $("#dialog").dialog("close");
	    $("#show_id").val(show_id);
		}
		$("#discs").change(function() {
			$("#tracks").html("<br>");
			for (var i=1; i<=$("#discs").selectedValues(); i++) {
				$("#tracks").append("<h5>Disc " + i + " Track Count:&nbsp;&nbsp;&nbsp;<input size='2' type='text' name='tracksDisc" + i + "'/></h5>");
			}
		});						
  });		
});