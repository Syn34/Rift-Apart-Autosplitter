//Introducing the "J4sp3rSynn1_ QuantumUltraMegaSlicer Pro-X 9000 v13.0" - an enigmatic marvel tailored for RiftApart!
//Unravel the secrets of effortless dimensional traversal as you gracefully navigate through gateways and diverse realms.
//Embrace the precision, unlocking frame-perfect splits and transcending the art of speedrunning.
//Crafted in unison by the genius of jasper3108 with the invaluable wisdom from Synn, this masterpiece embodies supreme style and innovation,
//embodying the very essence of RiftApart's speedrunning prowess.

state("RiftApart")
{
	bool isPortalLoading: 0x0671D108, 0x5308; //old 0671C088
	int isLoadingMap: 0x5F6D070; //old 0x5F6BFF8
	int cutscene: 0x6A44048, 0x0, 0xB8, 0x40, 0x28, 0x18, 0x10, 0x6BC; //this is a checkpoint thingy, old 0x06A42FC8
	int levelnr: 0x5150298; //old 0x514F298
}

isLoading
{
	return current.isPortalLoading || current.isLoadingMap!=0;
}
update
{
	if(current.cooldown>0) current.cooldown--;
	if(old.levelnr!=0) current.lastplanet = old.levelnr;
}

reset
{
	return old.cutscene != current.cutscene && current.cutscene == 1284869723;	
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
	bool didSplit = (current.levelnr != old.levelnr && !current.isPortalLoading && current.levelnr<11 && current.levelnr>2);

	if(current.cutscene == 1651971902 || current.cutscene == 183635574|| current.cutscene == 0) return;

	if((current.cutscene != old.cutscene && current.cutscene == 461962461) || (current.cutscene != old.cutscene && current.cutscene == 1002550897) || (didSplit && current.cooldown == 0 && current.levelnr != current.lastplanet)) {
		current.lastplanet = current.levelnr;
		current.cooldown = 60;
		return true;
        }
}
