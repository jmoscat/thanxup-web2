jQuery ->
  $('.best_in_place').best_in_place()
  $('[rel=tooltip]').tooltip()
  $('a[rel*=facebox]').facebox()

# ajax spinners

$(document).on "ajax:beforeSend", "*[data-spinner]", (e) ->
  $($(this).data("spinner")).show()
  e.stopPropagation() #Don't show spinner of parent elements.

$(document).on "ajax:complete", "*[data-spinner]", ->
  $($(this).data("spinner")).hide()

# facebox - make modal

$(document).bind "loading.facebox", ->
  $(document).unbind "keydown.facebox"
  $("#facebox_overlay").unbind "click"

# alert box html for js.erb files

@alert_box = (level, close_btn, msg) ->
  if close_btn == 'y'
    html = \
    "<div class='alert fade in alert-#{level}'>
    <button class='close' data-dismiss='alert'>\&times;</button>#{msg}</div>"
  else
    html = \
    "<div class='alert fade in alert-#{level}'>#{msg}</div>"
  return html

# customize (remove purr dependency) error messages from best_in_place gem
# modified from best_in_place.purr.js as suggested in the gem README

$(document).on "best_in_place:error", (event, request, error) ->
  jQuery.each jQuery.parseJSON(request.responseText), (index, value) ->
    value = index + " " + value.toString() if typeof (value) is "object"
    $('#best_in_place_errors').html(alert_box('error','y',value));
    
    