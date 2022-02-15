<?php

namespace App\Notifications;

use NotificationChannels\MicrosoftTeams\MicrosoftTeamsMessage;

class UptimeCheckFailed extends \Spatie\UptimeMonitor\Notifications\Notifications\UptimeCheckFailed
{
    public function toMicrosoftTeams($notifiable)
    {
        return MicrosoftTeamsMessage::create()
            ->to(config('services.teams.webhook_url'))
            ->type('error')
            ->title($this->getMessageText())
            ->content($this->getMessageText());
    }
}
