/* Hide/Show the left toolbar and right drawer so the site is fullscreen */
$(document).on('click', ".wcms-full-screen", function(e) {
	console.log("1. .wcms-full-screen was clicked, so toggle the left drawer");
	$("#wcms-wrapper").toggleClass("toolbar-visible");
	$(".wcms-drawer-left").toggle();
	$(".wcms-master-toolbar-link").removeClass("active");
});

$(document).on('click', ".wcms-master-toolbar-link", function(e) {
	console.log("2. .wcms-master-toolbar-link was clicked")
	$(".wcms-cell-toolbar-link").removeClass('active');
	$(".wcms-tool-container").hide();
	$(".wcms-work-cell").removeClass("pressed");
});

$(document).on('click', '.wcms-cell', function(e){
	var rowId = $(this).attr('data-row');
	var cellId = $(this).attr('data-cell');
	console.log("3. .wcms-cell was clicked so get update the appropriate toolbars for row " + rowId + " and cell " + cellId);
	if ($(e.target).closest(".wcms-back").length === 0) {
		$.ajax({
			type: 'get',
			dataType: 'script',
			url: '/admin/cells/' + cellId 
		})
	}
});

$("#wcms-work-area").on('click', 'div.wcms-cell div.wcms-tools', function(e){
	console.log("4. .wcms-tools was clicked inside wcms-cell, so don't do anything, allow user to edit form");
	e.stopPropagation();
});	

$(document).on("click", ".wcms-cell-toolbar-cells", function(e){
	e.stopPropagation();
	var dataSide = $(this).attr('data-side');
	var dataAction = $(this).attr('data-action');
	var dataRow = $(this).attr('data-row');
	var dataCell = $(this).attr('data-cell');
	console.log("5. .wcms-cell-toolbar-cells was clicked to create a new cell:" + dataSide + " | " + dataAction + " | " + dataRow + " | " + dataCell);
	$("#wcms-direction").val(dataSide);
	$("#wcms-deed").val(dataAction);
	$("#wcms-adjacent-cell").val(dataCell);
	$("#wcms-new-cell").submit();
});

$(document).on("click", ".wcms-cell-text", function(e){
	var dataRow = $(this).attr('data-row');
	var dataCell = $(this).attr('data-cell');
	console.log("6. .wcms-cell-text was clicked for row " + dataRow + " and cell " + dataCell);
	cell = $('#wcms-work-cell-' + dataCell);
});

$(document).on('click', ".wcms-cell-cancel-btn", function(e) {
	console.log("7. Cancel the cell editor mode (.wcms-cell-cancel-btn)");
	e.preventDefault();
	var dataRow = $(this).attr('data-row');
	var dataCell = $(this).attr('data-cell');
	$("#wcms-work-cell-" + dataCell).toggleClass('flipped');
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
	$(".wcms-work-cell").removeClass('flipped');
	$(".wcms-toolbar").hide();
	$("#wcms-wrapper").removeClass('toolbar-visible').delay(500).queue(function(next) {
		$("#wcms-master-toolbar").show();
		$(".wcms-cell-toolbar-vertical").hide();
		$(this).addClass("toolbar-visible");
		next();
	})

	$(".wcms-cell").removeClass("wcms-cell-active");
	var dataRow = $(this).attr('data-row');
	var dataCell = $(this).attr('data-cell');
	$("#wcms-toolbar-div-" + dataRow).fadeOut();
	$("#wcms-work-cell-" + dataCell).removeClass("wcms-cell-active");

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
    		console.log("13. hide wcms-tool-container and removed pressend and wcms-cell-active classes");
        var dataCell = $(e.target).closest(".wcms-work-cell").attr('data-cell');
        if(dataCell === undefined) {
					$(".wcms-tool-container").hide();
					$(".wcms-work-cell").removeClass("pressed wcms-cell-active");
        }
    }

    if ($(e.target).closest(".wcms-master-toolbar-link").length === 0) {
        if ($(e.target).closest("#wcms-sidebar-wrapper").length === 0) {
        	console.log("14. remove drawer-visible");
					$(".wcms-right-column").hide("slide", { direction: "right" }, 500);
					$(".wcms-form-box").hide();
					$(".wcms-master-toolbar-link").removeClass("active");
					$("#wcms-wrapper").removeClass("drawer-visible");
        }
    }
});





