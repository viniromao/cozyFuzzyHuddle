shader_type canvas_item;

uniform float pixelate: hint_range(2, 512, 4) = 256;
uniform vec4 color_1 = vec4(.09, .13, .22, 1.0);
uniform vec4 color_2 = vec4(.15, .23, .37, 1.0);
uniform vec4 color_3 = vec4(.24, .37, .55, 1.0);
uniform vec4 color_4 = vec4(.31, .56, .73, 1.0);
uniform vec4 color_5 = vec4(.45, .75, .83, 1.0);
uniform vec4 color_6 = vec4(.10, .20, .18, 1.0);
uniform vec4 color_7 = vec4(.15, .34, .18, 1.0);
uniform vec4 color_8 = vec4(.27, .51, .20, 1.0);
uniform vec4 color_9 = vec4(.46, .65, .26, 1.0);
uniform vec4 color_10 = vec4(.66, .79, .35, 1.0);
uniform vec4 color_11 = vec4(.82, .85, .57, 1.0);
uniform vec4 color_12 = vec4(.30, .17, .20, 1.0);
uniform vec4 color_13 = vec4(.48,.28, .25, 1.0);
uniform vec4 color_14 = vec4(.68, .47, .34, 1.0);
uniform vec4 color_15 = vec4(.75, .58, .45, 1.0);
uniform vec4 color_16 = vec4(.84, .71, .58, 1.0);
uniform vec4 color_17 = vec4(.91, .84, .70, 1.0);
uniform vec4 color_18 = vec4(.20, .11, .15, 1.0);
uniform vec4 color_19 = vec4(.38, .17, .17, 1.0);
uniform vec4 color_20 = vec4(.53, .29, .17, 1.0);
uniform vec4 color_21 = vec4(.75, .47, .17, 1.0);
uniform vec4 color_22 = vec4(.87, .62, .25, 1.0);
uniform vec4 color_23 = vec4(.91, .76, .44, 1.0);
uniform vec4 color_24 = vec4(.14, .08, .15, 1.0);
uniform vec4 color_25 = vec4(.25, .11, .19, 1.0);
uniform vec4 color_26 = vec4(.46, .14, .22, 1.0);
uniform vec4 color_27 = vec4(.65, .19, .19, 1.0);
uniform vec4 color_28 = vec4(.81, .34, .24, 1.0);
uniform vec4 color_29 = vec4(.85, .53, .24, 1.0);
uniform vec4 color_30 = vec4(.12, .11, .22, 1.0);
uniform vec4 color_31 = vec4(.25, .15, .32, 1.0);
uniform vec4 color_32 = vec4(.48, .21, .48, 1.0);
uniform vec4 color_33 = vec4(.64, .24, .55, 1.0);
uniform vec4 color_34 = vec4(.78, .32, .59, 1.0);
uniform vec4 color_35 = vec4(.87, .52, .65, 1.0);
uniform vec4 color_36 = vec4(.04, .04, .08, 1.0);
uniform vec4 color_37 = vec4(.06, .08, .12, 1.0);
uniform vec4 color_38 = vec4(.08, .11, .16, 1.0);
uniform vec4 color_39 = vec4(.13, .18, .22, 1.0);
uniform vec4 color_40 = vec4(.22, .29, .31, 1.0);
uniform vec4 color_41 = vec4(.34, .45, .47, 1.0);
uniform vec4 color_42 = vec4(.51, .59, .59, 1.0);
uniform vec4 color_43 = vec4(.66, .71, .70, 1.0);
uniform vec4 color_44 = vec4(.78, .81, .80, 1.0);
uniform vec4 color_45 = vec4(.92, .93, .91, 1.0);
uniform vec4 color_46 = vec4(0.8313725490196079, 0.7568627450980392, 0.592156862745098, 1.0);

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;


void fragment() {

	vec4 colors[46] = {color_1, color_2, color_3, color_4, color_5, color_6, color_7, color_8, color_9, color_10, color_11, color_12, color_13, color_14, color_15, color_16, color_17, color_18, color_19, color_20, color_21, color_22, color_23, color_24, color_25, color_26, color_27, color_28, color_29, color_30, color_31, color_32, color_33, color_34, color_35, color_36, color_37, color_38, color_39, color_40, color_41, color_42, color_43, color_44, color_45, color_46 };
	float min_diff = -1.0;
	vec4 min_color = vec4(0.0, 0.0, 0.0, 1.0);

	vec2 uv =  floor(UV * pixelate) / pixelate;

	vec4 temp = textureLod(SCREEN_TEXTURE, uv, 0.0);


	min_diff = 1000.0;
	for (int i = 0; i < colors.length(); i++) {

		float curr_dist = distance(colors[i], temp);
		if (curr_dist < min_diff) {
			min_diff = curr_dist;
			min_color = colors[i];
		}
	}

	
    COLOR = textureLod(SCREEN_TEXTURE, uv, 0.0);
	
	COLOR.rgb = min_color.rgb;
	
}