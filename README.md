# Hammer Road Maker
Developer tool that allows you to create curved brushed road in the game, and then export them to vmf.
It is useful when building roads on displacement surfaces (mountains, hills).

>## Public alpha 1.1:
>- Now the road is physical! Physics is disabled by default. Enter the ***roadmaker_enablephysics 1*** in console to enable.
>- Supports client/server communications.
>- Completely rewritten and improved internal libraries.


Choose weapon in the ***Hammer Road Maker*** category:

- Press R - Change mode.
- Press Mouse1 - Create or move point to cursor.
- Press Mouse2 - Remove last or select nearest point.

To display the points, enter the ***developer 1*** in console. This can cause a lower FPS with large amount of points.

## Console commands:
```
roadmaker_enablephysics - Enable physics of the road. Set 0 to disable.

roadmaker_height - Set height of the road.
roadmaker_width - Set width of the road.

roadmaker_clear - Delete all points.
roadmaker_getvmf - Export brushes to vmf file in data folder.

roadmaker_toptexture - Set top texture of the road.
roadmaker_sidetexture - Set side texture of the road.
roadmaker_bottomtexture - Set bottom texture of the road.
roadmaker_nodrawtexture - Set nodraw texture of the road.
```
To export your road mesh to vmf, enter the ***roadmaker_getvmf*** in console. Your vmf structure file will be in the data folder and is named ***vmfgenerator.vmf.txt***.

If you create extremely twisted roads, they will appear broken. Their vertices can merge into each other and cause inverted meshes. Hammer Editor will display "invalid solids" error message.

Available in Workshop: [Steam Workshop](http://steamcommunity.com/sharedfiles/filedetails/?id=974013129)
