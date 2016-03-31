/* Hide/Show the left toolbar and right drawer so the site is fullscreen */

$(document).on('click', ".wcms-master-toolbar-link", function(e) {
	console.log("2. .wcms-master-toolbar-link was clicked")
	$(".wcms-cell-toolbar-link").removeClass('active');
	$(".wcms-work-cell").removeClass("pressed");
});

$(document).on('click', '.wcms-cell', function(e){
	var rowId = $(this).attr('data-row');
	var cellId = $(this).attr('data-cell');

	console.log("3. .wcms-cell was clicked so get update the appropriate toolbars for row " + rowId + " and cell " + cellId);
	if ($(e.target).closest(".wcms-back").length === 0) {
		$(".wcms-cell-controls").hide('blind', {}, 500);
		$(".wcms-cell").removeClass("wcms-cell-active");
		
		$("#wcms-header-crop").removeClass("hidden");
		$("#wcms-crop-save").addClass("hidden");
		$("#wcms-crop-cancel").addClass("hidden");
		try { $('#wcms-header-img').data('Jcrop').destroy(); }
		catch(err) { console.log("No Jcrop") }
	  $('#wcms-header-img').removeAttr('style');
		
		$("#wcms-img-overlay").fadeIn();
		$(".wcms-overlapped-header").fadeIn();

		if(!$(e.target).closest(".wcms-above").length === 0) {
			console.log("3.00.1 remove bottom margin")
			$(".wcms-overlapped-header").not(".navbar-fixed-top").animate({
				bottom: "0"
			}, 500, function() {
				
			});
		}
		$.ajax({
			type: 'get',
			dataType: 'script',
			url: '/admin/cells/' + cellId 
		})
	}
});

$(document).on('click', '.wcms-header', function(e){
	var pageId = $(this).attr('data-page');	
	if ($(e.target).closest(".navbar-fixed-top").length === 0 && $(e.target).closest(".wcms-back").length === 0 && $(e.target).closest(".nav-line").length === 0 && $(e.target).closest(".jcrop-holder").length === 0) {
		console.log("3.25 .wcms-header was clicked");
		if($("#wcms-cell-controls-header").is(':visible')){
			console.log("3.25.01 #wcms-cell-control-header is visible");
			$(".wcms-cell-controls").hide('blind', {}, 500);
			console.log("1. ABOVE: " + $(e.target).closest(".wcms-above").length)
			console.log("1. BELOW: " + $(e.target).closest(".wcms-below").length)			
			if($(e.target).closest(".wcms-below").length === 1){
				console.log("3.25.1 remove bottom margin")
				$(".wcms-overlapped-header").not(".navbar-fixed-top").animate({
					bottom: "-=28"
				}, 500, function() {});
			}
		} else {
			$(".wcms-cell-controls").fadeOut();
			$(".wcms-cell").removeClass("wcms-cell-active");
			$("#wcms-header").addClass("wcms-cell-active");
			$("#wcms-cell-controls-header").show('blind', {}, 500);
			console.log("3.25.02 #wcms-cell-control-header is visible");
			console.log("2. ABOVE: " + $(e.target).closest(".wcms-above").length)
			console.log("2. BELOW: " + $(e.target).closest(".wcms-below").length)
			if($(e.target).closest(".wcms-below").length === 1){
				console.log("3.25.2 add bottom margin")
				$(".wcms-overlapped-header").not(".navbar-fixed-top").animate({
					bottom: "+=28"
				}, 500, function() {});
			}
		}
	}
});

$(document).on('click', '#wcms-undo', function(e){
	e.stopPropagation();
	console.log("3.5. .wcms-undo undo cell delete");
	$("#wcms-restore-cell").submit();	
});

$("#wcms-work-area").on('click', 'div.wcms-cell div.wcms-tools', function(e){
	console.log("4. .wcms-tools was clicked inside wcms-cell, so don't do anything, allow user to edit form");
	e.stopPropagation();
});	

$(document).on("click", ".wcms-cell-toolbar-cells", function(e){
	e.stopPropagation();
	var dataSide = $(this).attr('data-side');
	var dataAction = $(this).attr('data-action');
	console.log("5. .wcms-cell-toolbar-cells was clicked to create a new cell:" + dataSide + " | " + dataAction);
	$("#wcms-direction").val(dataSide);
	$("#wcms-deed").val(dataAction);
	$("#wcms-new-cell").submit();
});

$(document).on("click", ".wcms-cell-text", function(e){
	var dataRow = $(this).attr('data-row');
	var dataCell = $(this).attr('data-cell');
	console.log("6. .wcms-cell-text was clicked for row " + dataRow + " and cell " + dataCell);
	cell = $('#wcms-cell-' + dataCell);
});

$(document).on('click', ".wcms-cell-cancel-btn", function(e) {
	console.log("7. Cancel the cell editor mode (.wcms-cell-cancel-btn)");
	e.preventDefault();
	var dataRow = $(this).attr('data-row');
	var dataCell = $(this).attr('data-cell');
	$("#wcms-cell-" + dataCell).toggleClass('flipped');
	$(".wcms-header").removeClass("flipped");
	$(".wcms-cell-toolbar-link").removeClass('active');
});	

/*** Save the change from CKEDITOR for this cell ***/
$(document).on('click', ".wcms-save", function (e) {
	console.log("8. Save the editor's content to the server");
	var dataRow = $(this).attr('data-row');
	var dataCell = $(this).attr('data-cell');
	var bodyValue = $("#wcms-editor-" + dataCell).html();
	$("#cell_body_" + dataCell).val(bodyValue);
	$("#edit_cell_" + dataCell).submit();
});

/*** Cancel the CKEDITOR instance ***/
$(document).on('click', ".wcms-cancel", function(e) {
	console.log("9. Cancel the cell editor mode (.wcms-cancel)");
	e.preventDefault();
	$(".wcms-cell-toolbar-link").removeClass('active');
	$(".wcms-work-cell, .wcms-header").removeClass('flipped');
	$(".wcms-toolbar").hide();

	$(".wcms-cell").removeClass("wcms-cell-active");
	var dataRow = $(this).attr('data-row');
	var dataCell = $(this).attr('data-cell');
	$("#wcms-toolbar-div-" + dataRow).fadeOut();
	$("#wcms-cell-" + dataCell).removeClass("wcms-cell-active");

});

$(document).on('click', "#wcms-add-row", function(e){
	console.log("10. Create a new row");
	e.preventDefault();
	$("#wcms-new-row").submit();
});


$(document).on("click", ".wcms-cell-toolbar-link", function(e){
	var adjacent_cell = $(this).attr('data-cell');
	console.log("11. Update the adjacent cell field to " + adjacent_cell);
	$("#wcms-adjacent-cell").val(adjacent_cell);
});

$(document).on("click", ".wcms-account", function() {
	var panel = $(this).attr('data-info');
	console.log("12. .wcms-account was clicked for panel " + panel);
	$(".wcms-account-div").hide();
	$("#" + panel + "-index-div").fadeIn();
});

$(document).on('click', function (e) {
  if ($(e.target).closest(".wcms-tool-container").length === 0) {
		console.log("13. hide wcms-tool-container and removed pressed and wcms-cell-active classes");
    var dataCell = $(e.target).closest(".wcms-work-cell").attr('data-cell');
    var dataPage = $(e.target).closest("#wcms-header").attr('data-page');
    console.log("13.1 OVERLAPPED HEADER BOTTOM IS " + $(".wcms-overlapped-header").css('bottom'));
    jcrop_object = $('#wcms-header-img').data('Jcrop')

    if(dataCell === undefined && dataPage === undefined) {
    	console.log("13.2")
    	if(jcrop_object == null) {
    		console.log("13.3")
				$("#wcms-cell-controls-header").hide('blind', {}, 500);
				$(".wcms-cell-controls").fadeOut();
			}

			$(".wcms-cell").removeClass("wcms-cell-active");
			$(".wcms-tool-container").hide();
			$(".wcms-work-cell").removeClass("pressed wcms-cell-active");
    }
  }

  if ($(e.target).closest(".wcms-master-toolbar-link").length === 0) {
    if ($(e.target).closest("#wcms-sidebar-wrapper").length === 0) {
    	console.log("14. remove drawer-visible");
			$(".wcms-right-column").hide("slide", { direction: "right" }, 500);
			$(".wcms-form-box").hide();
			$("#wcms-wrapper").removeClass("drawer-visible");
			$("#wcms-master-menu .dropdown-item").removeClass("active");
    }
  }
});

$(document).on('click', "#wcms-header-crop", function(e) {
	console.log("15. Use Jcrop to edit the header image");
	e.preventDefault();
	$('#wcms-header-img').Jcrop({
		onSelect: update_crop,
		onChange: update_crop
	});
	$("#wcms-header-crop").addClass("hidden");
	$("#wcms-crop-save").removeClass("hidden");
	$("#wcms-crop-cancel").removeClass("hidden");
	$("#wcms-img-overlay").fadeOut();
	$(".wcms-overlapped-header").fadeOut();

});

$(document).on('click', "#wcms-crop-save", function(e) {
	console.log("16. Submit the cropping form");
	e.preventDefault();
	$("#wcms-crop-form").submit();
});

$(document).on('click', "#wcms-crop-cancel", function(e) {
	console.log("16.5 Cancel the Jcrop");
	e.preventDefault();
	$("#wcms-header-crop").removeClass("hidden");
	$("#wcms-crop-save").addClass("hidden");
	$("#wcms-crop-cancel").addClass("hidden");
	try { $('#wcms-header-img').data('Jcrop').destroy(); }
	catch(err) { console.log("No Jcrop") }
  $('#wcms-header-img').removeAttr('style');
  $("#wcms-img-overlay").fadeIn();
	$(".wcms-overlapped-header").fadeIn();
});

function update_crop(coords) {
  var rx = 100/coords.w;
  var ry = 100/coords.h;
  $("#crop_x").val(Math.round(coords.x));
  $("#crop_y").val(Math.round(coords.y));
  $("#crop_w").val(Math.round(coords.w));
  $("#crop_h").val(Math.round(coords.h));
  $("#placed_w").val(Math.round($("#wcms-header-img").width()));
  $("#placed_h").val(Math.round($("#wcms-header-img").height()));
}


