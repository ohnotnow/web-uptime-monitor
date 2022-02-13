<?php

namespace Spatie\UptimeMonitor\Notifications\Notifications;

use Carbon\Carbon;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Messages\SlackMessage;
use Illuminate\Notifications\Messages\SlackAttachment;
use Spatie\UptimeMonitor\Notifications\BaseNotification;
use NotificationChannels\MicrosoftTeams\MicrosoftTeamsMessage;
use Spatie\UptimeMonitor\Events\CertificateCheckFailed as InValidCertificateFoundEvent;

class CertificateCheckFailed extends \Spatie\UptimeMonitor\Notifications\Notifications\CertificateCheckFailed
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
