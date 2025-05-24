
## For Google Chrome

get your chrome version like 134.0.6998.165
```sh
google-chrome --version
```

download chromedriver (there is [the zip archive for v 134.0.6998.165](./extra/chromedriver-linux64.zip))
```sh
wget https://storage.googleapis.com/chrome-for-testing-public/{version of chrome}/linux64/chromedriver-linux64.zip
```

then install it
```sh
unzip chromedriver_linux64.zip

sudo mv chromedriver_linux64/chromedriver /usr/bin/chromedriver
sudo chown root:root /usr/bin/chromedriver
sudo chmod +x /usr/bin/chromedriver
```

and test this thing
```sh
chromedriver --url-base=/wd/hub
```


### Links
guide:https://skolo.online/documents/webscrapping/#pre-requisites

chrome for testing versions: https://googlechromelabs.github.io/chrome-for-testing/
