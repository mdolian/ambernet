$(function() {
  jQuery(document).ready(function($) {
		$("div[id*='accordion']").accordion({
			autoHeight: false, 
			collapsible: true
		});
		("a[id='image_anchor']").fancybox();
  });				
});		