<?php

namespace App\Notifications;

use NotificationChannels\MicrosoftTeams\MicrosoftTeamsMessage;

class UptimeCheckRecovered extends \Spatie\UptimeMonitor\Notifications\Notifications\UptimeCheckRecovered
{
    public function toMicrosoftTeams($notifiable)
    {
        return MicrosoftTeamsMessage::create()
            ->to(config('services.teams.webhook_url'))
            ->type('success')
            ->title($this->getMessageText())
            ->content($this->getMessageText());
    }
}
