{ pkgs, ... }:
{
  systemd.user.services.quote-notifier = {
    Unit = {
      Description = "Hourly motivational quote notifier";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.writers.writeJS "quote-notifier" {} ''
        import { exec } from 'child_process';
        import util from 'util';
        const execPromise = util.promisify(exec); 

        try {
            const response = await fetch('https://zenquotes.io/api/random');
            const data = await response.json();
            const quote = data[0].q;
            const author = data[0].a || 'Unknown';

            const message = quote + "\n — " + author;
            await execPromise('notify-send -i face-smile "Motivational Quote" "' + message + '"');
          } catch (error) {
            console.error('Error fetching/posting quote:', error);
            await execPromise('notify-send -i face-smile "Motivational Quote" "Don\'t give up when your motivational quote script fails"');
        }
      ''}";
      Restart = "always";
      RestartSec = 3600;
    };
  };
}
