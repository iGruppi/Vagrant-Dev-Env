# Vagrant-Dev-Env
Vagrant è di grande supporto nella realizzazione di macchine virtuali e del loro mantenimento. 
Grazie a Vagrant e Virtualbox è possibile costruire rapidamente l'ambiente di sviluppo di iGruppi.

# Requisiti
- [Virtualbox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com)
- [Plugin Vagrant VBGuest](https://github.com/dotless-de/vagrant-vbguest)

# Installazione
Dopo aver installato Vagrant installare il plugin vbguest:
```
$ vagrant plugin install vagrant-vbguest
```

Dopo aver installato i due software qui sopra creare una nuova directory di lavoro ed eseguire i seguenti comandi:
```
$ git clone https://github.com/iGruppi/iGruppi.git
$ git clone https://github.com/iGruppi/Vagrant-Dev-Env.git
$ cd Vagrant-Dev-Env
$ vagrant up
```

