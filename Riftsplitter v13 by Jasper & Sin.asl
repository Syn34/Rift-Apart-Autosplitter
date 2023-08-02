//Made by jasper3108 with help from Syn
//Testing help from Bdud5

state("RiftApart")
{
	bool isPortalLoading: 0x0671D108, 0x5308; //old 0671C088
	int isLoadingMap: 0x5F6D070; //old 0x5F6BFF8
	int cutscene: 0x6A44048, 0x0, 0xB8, 0x40, 0x28, 0x18, 0x10, 0x6BC; //this is a checkpoint thingy, old 0x06A42FC8
	int levelnr: 0x5150298; //old 0x514F298
}

//TODO: Auto migration script

isLoading
{
	return current.isPortalLoading || current.isLoadingMap!=0;
}
update
{
	if(current.cooldown>0) current.cooldown--;
	if(old.levelnr!=0) current.lastplanet = old.levelnr;
}

init
{
	current.cooldown = 0;
	current.lastplanet = 0;
}

start
{
	return old.cutscene == -248454360 && current.cutscene == -435133137;
}

split
{
	bool didSplit = (current.levelnr != old.levelnr && current.levelnr!=2 && current.levelnr!=1 && current.levelnr!=0 && !current.isPortalLoading && current.levelnr<11 && current.levelnr>1);

	if(current.cutscene == 1651971902) return;

	if((current.cutscene != old.cutscene && current.cutscene == 461962461) || (current.cutscene != old.cutscene && current.cutscene == 1002550897) || (didSplit && current.cooldown == 0 && current.levelnr != current.lastplanet)) {
		current.lastplanet = current.levelnr;
		current.cooldown = 60;
		return true;
        }
}
