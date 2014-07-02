git clone https://github.com/Microsoft-CISL/REEF.git
git clone https://github.com/Microsoft-CISL/Wake.git
git clone https://github.com/Microsoft-CISL/TANG.git
export REEF_HOME=$HOME/REEF && echo "export REEF_HOME=$REEF_HOME" >> .profile

# Tang install
cd TANG
git pull
mvn clean install 
cd ~

# Wake install
cd Wake
git pull
mvn clean install
cd ~

# Reef install
cd REEF
git pull
mvn clean install
cd ~

