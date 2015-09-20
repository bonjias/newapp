# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class TimeEntries
  
  constructor: () ->

  _bind: () =>
    #   Bind client events
    $('#get_toggl').on('click', (event) =>
      el = $(event.currentTarget)
      el.prop('disabled', true)
      @do_get(el.attr('data-url'), (data)=>
        @fill_table(data)
        el.prop('disabled', false)
      )
    ).click()
    
    $('#new_invoice').on('click', (event) =>
      el = $(event.currentTarget)
      el.prop('disabled', true)
      @do_get(el.attr('data-url'), (data)=>
        console.log(data)
        el.prop('disabled', false)
        location.reload()
      )
    )
    
    
  fill_table: (data) ->
    
    if not data
      return false
    
    console.log(data)
    
    table = document.getElementById('time_entries')
    total_hours = 0
    total_fees = 0
    avg_rate = 0
    
    for row in data
      row_ = table.insertRow(0)
      for cell, i in ['start', 'end', 'description', 'tags', ]
        cell_ = row_.insertCell(i)
        cell_.innerHTML = row[cell]
      
      # Hours
      cell_ = row_.insertCell(4)
      hours = (new Date(row['end']) - new Date(row['start'])) / (1000 * 3600)
      total_hours += hours
      cell_.innerHTML = hours.toFixed(2)
      
      # Rate
      cell_ = row_.insertCell(5)
      avg_rate += row['rate']
      cell_.innerHTML = '$' + row['rate'].toFixed(2)
      
      # Fees
      cell_ = row_.insertCell(6)
      fees = (hours * row['rate'])
      total_fees += fees
      cell_.innerHTML = '$' + fees.toFixed(2)
    
    avg_rate /= data.length
    
    # Total row
    total_row = table.rows[table.rows.length-1]
    console.log(total_row.cells)
    console.log(total_row.cells[1].getAttribute('data-number'))
    total_hours += parseFloat(total_row.cells[1].getAttribute('data-number'))
    total_row.cells[1].innerHTML = total_hours.toFixed(2)
    total_fees += parseFloat(total_row.cells[3].getAttribute('data-number'))
    total_row.cells[3].innerHTML = '$' + total_fees
    
  do_get: (url, callback) ->
    jQuery.get(url, (data) ->
      callback(data)
    )

times = new TimeEntries()

$(document).ready(times._bind)
$(document).on('page:load', times._bind)