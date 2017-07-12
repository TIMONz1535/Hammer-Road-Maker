# Hammer Road Maker
A simple tool that allows you to create curved brushed road in the game, and then export them to vmf.
It is useful when building roads on displacement surfaces (mountains, hills).
I was in a hurry when I made this version.
Therefore, it may contain a significant amount of bad coding.

Choose weapon in the ***Hammer Road Maker*** category
```
Press R - Change mode
Press Mouse1 - Create or move point to cursor
Press Mouse2 - Remove last or select nearest point
```
To display the points, enter the developer 1 in console. This can cause a lower FPS with large amount of points.

## Console commands:
```
roadmaker_height - Set height of road
roadmaker_width - Set width of road

roadmaker_clear - Delete all points
roadmaker_getvmf - Export brushes to vmf file in data folder

roadmaker_toptexture - Set top texture for road
roadmaker_sidetexture - Set side texture for road
roadmaker_bottomtexture - Set bottom texture for road
roadmaker_nodrawtexture - Set nodraw texture for road

roadmaker_updatemesh - Internal function to update the road.
```
To export your road mesh to vmf, enter the ***roadmaker_getvmf*** in console. Your vmf structure file will be in the data folder and is named ***vmfgenerator.vmf.txt***.

If you create extremely twisted roads, they will appear broken. Their vertices can merge into each other and cause inverted meshes. Hammer Editor will display "invalid solids" error message.

Available in Workshop: http://steamcommunity.com/sharedfiles/filedetails/?id=974013129
