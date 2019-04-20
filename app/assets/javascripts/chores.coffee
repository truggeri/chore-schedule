# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@chore_new_submit = () ->
  $('#new_chore').trigger( "submit" )
  return

@adjust_delete_path = (path, name) ->
  $.ajaxSetup url: path
  $('#chore-name').text(" " + name)
  return

initial_delete_setup = () ->
  $.ajaxSetup
    type: 'DELETE'
    headers: 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    statusCode: 302: (response) ->
      redirect_url = response.getResponseHeader('X-Ajax-Redirect-Url')
      if redirect_url != undefined
        window.location.pathname = redirect_url
      return
  return

initial_delete_setup()

@perform_chore_now = (path) ->
  $.ajaxSetup
    url: path
    type: 'GET'
    headers: 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    statusCode: 302: (response) ->
      redirect_url = response.getResponseHeader('X-Ajax-Redirect-Url')
      if redirect_url != undefined
        window.location.pathname = redirect_url
      return
  $.ajax()
  return