@extends('layouts.app')
@section('title', 'Calendar')
@section('content')
<div id="calendar"></div>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
<script>
	document.addEventListener('DOMContentLoaded', function() {

		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			// toolbar
			headerToolbar: {
				start: 'title',
				center: '',
				end: 'multiMonthYear,dayGridMonth,dayGridWeek,timeGridDay listWeek',
			},
			footerToolbar: {
				start: 'prevYear,prev',
				center: 'today',
				end: 'next,nextYear',
			},

			// set business days
			businessHours: {
				daysOfWeek: [ 1, 2, 3, 4, 5],
				
				startTime: '8:00',
				endTime: '17:00',
			},

			// view
			initialView: 'dayGridMonth',
			fixedWeekCount: false,
			weekNumbers: true,
			events: @json($events),
			aspectRatio: 1.5,
			contentHeight: 700,

			// event stack
			dayMaxEventRows: true,
			dayMaxEvents: 3,
			moreLinkClick: 'popover',

			// funcions
			selectable: true,
			dateClick: function(info) {
				info.dayEl.style.backgroundColor = 'var(--dark)';
			},
		});
		
		calendar.render();

	});
</script>
@endsection