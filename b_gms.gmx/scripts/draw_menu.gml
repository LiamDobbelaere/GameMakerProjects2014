//draw_menu(selectionvar, option1, option2, option3, option4, colordef, colorsel)

opt0 = " " + argument1
opt1 = " " + argument2
opt2 = " " + argument3
opt3 = " " + argument4
col0 = argument5
col1 = argument5
col2 = argument5
col3 = argument5


if argument0 == 0 and argument1!="" then
{
    opt0 = ">" + argument1
    col0 = argument6
}
else if argument0 == 1 and argument2!="" then
{
    opt1 = ">" + argument2
    col1 = argument6
}
else if argument0 == 2 and argument3!="" then
{
    opt2 = ">" + argument3
    col2 = argument6
}
else if argument0 == 3 and argument4!="" then
{
    opt3 = ">" + argument4
    col3 = argument6
}

draw_pixeltext(15, 17, opt0, col0, c_ltgray, 0, 0)
draw_pixeltext(22, 17, opt1, col1, c_ltgray, 0, 0)
draw_pixeltext(15, 18, opt2, col2, c_ltgray, 0, 0)
draw_pixeltext(22, 18, opt3, col3, c_ltgray, 0, 0)
