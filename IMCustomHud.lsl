// INEVITABLE MADNESS CUSTOM HUD SCRIPT
// WRITTEN BY PANDAHCHAN
// VERSION 1.0 ALPHA

// Hud Positions for Each Applier System
vector OMEGA = <0,0,0>;
vector BELLEZA = <0,0,90>;
vector SLINK = <0,0,180>;
vector MAITREYA = <0,0,270>;
vector VISTA = <0,270,0>;

//Shows all buttons which are avaiilable on the HUD
buttonShow()
{
    integer i;
    // Maybe try and fix this mess?
    list BUTTONS = [9,10,11,12,13,14,15,20,21,22,23,24,25,2,3,4,5,6,7,8,19];
    do
    {
        llSetLinkAlpha(llList2Integer(BUTTONS,i), 1.0,2);
    }
    while (++i < llGetListLength(BUTTONS));
}

//Get link number with prim name
integer getLinkWithName(string name)
{
    integer i = llGetLinkNumber() != 0;
    integer x = llGetNumberOfPrims() + i;

    for(; i < x; ++i)
    {
        if (llGetLinkName(i) == name)
        {
            return i;
        }
    }
    return -1;
}

integer open_button_link;
key user;
key merchant;

default
{
    changed(integer change)
    {
        if (change & CHANGED_OWNER)
            llResetScript();
    }

    attach(key id)
    {
        if (id != llGetOwner())
        {
            llResetScript();
        }
    }

    state_entry()
    {
        open_button_link = getLinkWithName("Open");
        llSetLinkAlpha(-1, 0.0, ALL_SIDES);
        llSetLinkAlpha(open_button_link,1.0,ALL_SIDES);
        llSetLinkPrimitiveParamsFast(LINK_ROOT, [PRIM_ROT_LOCAL, llEuler2Rot(OMEGA*DEG_TO_RAD), PRIM_LINK_TARGET, open_button_link, PRIM_POS_LOCAL, <-1,0,0>]);
        user = llGetOwner();
        merchant = llGetCreator();
    }

    touch_start(integer total_number)
    {
        //Touched link details
        integer touched_link_number = llDetectedLinkNumber(0);
        string touched_link_name = llGetLinkName(touched_link_number);

        list params;

        // Check which button is pressed
        // Opens it from the bat wings.
        if (touched_link_name == "Open")
        {
            buttonShow();
            //Find position of prim and increase it by 1
            vector link_pos = llList2Vector(llGetLinkPrimitiveParams(open_button_link, [PRIM_POS_LOCAL]), 0);
            link_pos.z += 1.2;
            llSetLinkAlpha(-4, 1.0, ALL_SIDES);
            llSetLinkPrimitiveParams(open_button_link, [PRIM_POS_LOCAL, link_pos]);

            // Set root prim with script in to visible.
        }

        // Close the hud
        else if (touched_link_name == "Kill HUD")
        {
            llSetLinkAlpha(-1, 0.0, ALL_SIDES);
            vector link_pos = llList2Vector(llGetLinkPrimitiveParams(open_button_link, [PRIM_POS_LOCAL]), 0);
            link_pos.z -= 1.2;
            llSetLinkPrimitiveParamsFast(LINK_ROOT, [PRIM_ROT_LOCAL, llEuler2Rot(OMEGA*DEG_TO_RAD), PRIM_LINK_TARGET, open_button_link, PRIM_POS_LOCAL, link_pos]);
            llSetLinkAlpha(open_button_link, 1.0, ALL_SIDES);
        }
        // Omega button
        else if (touched_link_name == "Omega")
        {
            llSetLinkPrimitiveParamsFast(LINK_ROOT, [PRIM_ROT_LOCAL, llEuler2Rot(OMEGA*DEG_TO_RAD)]);
        }

        // Slink Button
        else if (touched_link_name == "Lelutka")
        {
            llSetLinkPrimitiveParamsFast(LINK_ROOT, [PRIM_ROT_LOCAL, llEuler2Rot(SLINK*DEG_TO_RAD)]);
        }

        // Maitreya Button
        else if (touched_link_name == "Catwa")
        {
            llSetLinkPrimitiveParamsFast(LINK_ROOT, [PRIM_ROT_LOCAL, llEuler2Rot(MAITREYA*DEG_TO_RAD)]);
        }

        // Belleza Button
        else if (touched_link_name == "Belleza")
        {
            llSetLinkPrimitiveParamsFast(LINK_ROOT, [PRIM_ROT_LOCAL, llEuler2Rot(BELLEZA*DEG_TO_RAD)]);
        }

        // Vista Button
        else if (touched_link_name == "Vista")
        {
            llSetLinkPrimitiveParamsFast(LINK_ROOT, [PRIM_ROT_LOCAL, llEuler2Rot(VISTA*DEG_TO_RAD)]);
        }

        // Redelivery Button
        else if (touched_link_name == "Redelivery")
        {
            llMessageLinked( LINK_THIS, 0, "REDELIVER|"+(string)merchant, user );
        }

        // Flickr page.
        else if (touched_link_name == "Flickr")
        {
            string info = "Visit the Inevitable Madness Flickr page.";
            string url = "https://www.flickr.com/photos/inevitablemadness";
            llLoadURL(user, info, url);
        }

        // Marketplace Link.
        else if (touched_link_name == "Marketplace")
        {
            string info = "Visit the Inevitable Madness Marketplace.";
            string url = "https://marketplace.secondlife.com/stores/177939";
            llLoadURL(user, info, url);
        }

        // Facebook page.
        else if (touched_link_name == "Facebook")
        {
            string info = "Visit the Inevitable Madness Facebook.";
            string url = "https://www.facebook.com/InevitableMadnessOfficial/";
            llLoadURL(user, info, url);
        }

        else if (touched_link_name == "Landmark")
        {
            llGiveInventory(user, llGetInventoryName(INVENTORY_LANDMARK, 0));
        }
    }
}
