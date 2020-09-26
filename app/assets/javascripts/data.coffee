# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready( ->
  $('#upload_csv_file').on('change', ->
    $('#uploadCSVSubmit').attr('disabled', false)
  )

  $('#uploadCSVForm').bind('ajax:success', (event) ->
    $('#uploadCSVSubmit').attr('disabled', true)
    $('#uploadCSVForm')[0].reset()
    alert('Data imported successfully')
  )

  $('#uploadCSVForm').bind('ajax:error', (event) ->
    alert('Error happened when processing')
  )

  $('#questionsTable').DataTable({
    "pagingType": "full_numbers",
    "order": [[ 1, "asc" ]],
    "searching": false,
    "scrollY": "500"
  })
  $('.dataTables_length').addClass('bs-select')
)
