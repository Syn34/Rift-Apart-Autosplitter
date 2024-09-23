//Introducing the "J4sp3rSynn1_ QuantumUltraMegaSlicer Pro-X 9000 v13.0" - an enigmatic marvel tailored for RiftApart!
//Unravel the secrets of effortless dimensional traversal as you gracefully navigate through gateways and diverse realms.
//Embrace the precision, unlocking frame-perfect splits and transcending the art of speedrunning.
//Crafted in unison by the genius of jasper3108 with the invaluable wisdom from Synn, this masterpiece embodies supreme style and innovation,
//embodying the very essence of RiftApart's speedrunning prowess.
//Patch for v2.618.0.0 by Nhekno.

state("RiftApart")
{
	bool isPortalLoading: 0x674CAC8, 0x5308;
	//0x6741268, 0x5308
	//Nhekno: old 1.922.0.0 -> 0x673E708, 0x5308
	//0x5314
	//Nhekno: old 0x0671E108
	//old 0671C088, 48 03 39 66 83 BA E2 00 00 00 01 75 10 FF 4F 08 49 8B C8 48 83 C4 20 5F E9 2F 13 0E 00 48 89 5C 24 30 48 8B 1F 48 89 74 24 38 33 F6 48 85 DB 74 37
	
	int isLoadingMap: 0x5F94EC8;
	//Nhekno: old 1.922.0.0 -> 0x5F86DC8
	//Nhekno: old 0x5F6E070
	//old 0x5F6BFF8, 83 FA FF 75 12 48 8B 05 34 76 14 05 83 B8 00 8B 00 00 03 0F 94 C0 C3 48 63 C2 48 05 DA 03 00 00 48 8D 0C C0 48 8B 05 15 76 14 05 83 3C 88 03 0F 94 C0 C3 CC (cmp dword ptr [rax+00008B00],03)
	
	int cutscene: 0x6A73A60, 0x0, 0x208, 0x314;
	//Nhekno: old 1.922.0.0 -> 0x6A65680, 0x0, 0x208, 0x314
	//Nhekno: old 0x6A45048, 0x0, 0x208, 0x314
	//this is a checkpoint thingy, alternatively replace 0x0 with 0x28 base ptr actually hase symbol: RiftApart.AK::SoundEngine::g_PlayingID

	int levelnr: 0x5165298;
	//Nhekno: old 1.922.0.0 -> 0x5157298
	//Nhekno: old 0x5151298
	//old 0x514F298 74 10 48 8B C8 E8 74 04 45 01 F3 0F 11 83 50 01 00 00 8B 05 2E B3 C7 04 48 8D 0D AF 75 C3 05 89 83 68 01 00 00 E8 54 4E 56 01 8B 48 28 89 8B 6C 01 00 00 48 83 C4 20 5B C3
}

isLoading
{
	return current.isPortalLoading || current.isLoadingMap!=0;
}
update
{
	if(current.cooldown>0) current.cooldown--;
	if(old.levelnr!=0) current.lastplanet = old.levelnr;
	//print("Current level is " + current.levelnr);
	//print("Last level is " + current.lastplanet);
	//print("Current cutscene is " + current.cutscene);
	//print("Current cooldown is " + current.cooldown);
}

reset
{
	return !(timer.Run.CategoryName.Equals("100%")) && old.cutscene != current.cutscene && current.cutscene == 1284869723;	
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

	if(current.cutscene == 1651971902 || current.cutscene == 183635574 || current.cutscene == 0) return;

	if((current.cutscene != old.cutscene && current.cutscene == 461962461) || (current.cutscene != old.cutscene && current.cutscene == 1002550897) || (didSplit && current.cooldown == 0 && current.levelnr != current.lastplanet)) {
		current.lastplanet = current.levelnr;
		current.cooldown = 60;
		return true;
        }
}
