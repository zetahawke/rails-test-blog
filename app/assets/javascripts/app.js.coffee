$ = jQuery

$(document).on "ready page:load", ->
	$("#btn-follow").on "click", ->
		friend = $(this).data("friend")
		btn = $(this)
		$.ajax "/users/follow",
			type: "POST"
			dataType: "JSON"
			data: {user: { friend_id: friend}}
			success: (data) ->
				console.log data
				btn.slideUp()
			error: (err) ->
				console.log err
				alert "No hemos podido crear la amistad"