$(function() {
  jQuery(document).ready(function($) {
  	$("#nav ul li a").corner();
  });
  jQuery(document).ready(function($) {
		$("div[id*='accordion']").accordion({
			autoHeight: false, 
			collapsible: true
		});
  });		
});