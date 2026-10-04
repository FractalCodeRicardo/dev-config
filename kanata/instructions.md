# Instructions

sudo cargo install kanata

mkdir ~/.config/kanata

move kanata config file to the folder

# service
sudo nano /etc/systemd/system/kanata.service

[Unit]
Description=Kanata keyboard remapper
After=local-fs.target

[Service]
Type=simple
ExecStart=/home/ricardo/.cargo/bin/kanata --cfg /home/ricardo/.config/kanata/kanata.kbd
Restart=on-failure

[Install]
WantedBy=multi-user.target

# start service
sudo systemctl daemon-reload
sudo systemctl enable --now kanata.service

