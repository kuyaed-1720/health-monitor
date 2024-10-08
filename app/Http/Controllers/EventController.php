<?php

namespace App\Http\Controllers;

use App\Models\Events;
use Illuminate\Http\Request;

class EventController extends Controller
{
    public function showCalendar()
    {
        $events = Events::all(['id', 'title', 'start', 'end']);
        return view('events.calendar', ['events' => $events]);
    }

    public function displayEvents()
    {
        $events = Events::all();
        $eventData = [];

        foreach ($events as $event) {
            $eventData[] = [
                'id' => $event->id,
                'title' => $event->title,
                'start' => $event->start,
                'end' => $event->end,
            ];
        }

        $eventData = [
            'events' => $events
        ];

        return response()->json($eventData);
    }
}
