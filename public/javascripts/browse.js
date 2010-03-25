$(function() {
  jQuery(document).ready(function($) {
		$('li').addClass('current');

		$("#browseForm").formwizard({ 
			validationEnabled : true,
			focusFirstInput : true
		});
	});
});