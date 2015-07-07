set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050000 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2013.01.01'
,p_release=>'5.0.0.00.31'
,p_default_workspace_id=>50654249616769752
,p_default_application_id=>96962
,p_default_owner=>'APEX_VMORNEAU'
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/plugins/region_type/me_vmorneau_facebook_comments
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(8941874312557712256)
,p_plugin_type=>'REGION TYPE'
,p_name=>'ME.VMORNEAU.FACEBOOK.COMMENTS'
,p_display_name=>'Facebook Comments'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'function render_facebook_comments (',
'    p_region in apex_plugin.t_region,',
'    p_plugin in apex_plugin.t_plugin,',
'    p_is_printer_friendly in boolean )',
'return apex_plugin.t_region_render_result',
'as',
'    subtype plugin_attr is varchar2(32767);',
'',
'    -- Variables',
'    l_result apex_plugin.t_region_render_result;',
'    l_html varchar2(32767);',
'',
'    -- Component attributes',
'    l_colorscheme   plugin_attr := p_region.attribute_01;',
'    l_num_posts     plugin_attr := p_region.attribute_02;',
'    l_order_by      plugin_attr := p_region.attribute_03;',
'    l_width         plugin_attr := p_region.attribute_04;',
'    l_pk_item       plugin_attr := p_region.attribute_05;',
'    l_pk_item_val   plugin_attr := v(p_region.attribute_05);',
'begin',
'    -- debug information will be included',
'    if apex_application.g_debug then',
'        apex_plugin_util.debug_region (',
'            p_plugin => p_plugin,',
'            p_region => p_region,',
'            p_is_printer_friendly => p_is_printer_friendly);',
'    end if;',
'',
'    /*     ',
'    Given that an APEX page can hold dynamic content, is it important to remove the session_id from the URL that is sent to Facebook.',
'    */',
'    l_html :=   ''<div class="fb-comments" ',
'                    data-href="'' || owa_util.get_cgi_env(''HTTP_HOST'') || owa_util.get_owa_service_path || ''f?p='' || :APP_ID || '':'' || :APP_PAGE_ID || '':::::'' || l_pk_item || '':'' || l_pk_item_val || ''" ',
'                    data-numposts="'' || l_num_posts || ''" ',
'                    data-width="'' || l_width || ''"',
'                    data-order-by="'' || l_order_by || ''"',
'                    data-colorscheme="'' || l_colorscheme || ''"></div>''',
'            ||  ''<div id="fb-root"></div>''',
'            ||  ''<script>(function(d, s, id) {''',
'            ||      ''var js, fjs = d.getElementsByTagName(s)[0];''',
'            ||      ''if (d.getElementById(id)) return;''',
'            ||      ''js = d.createElement(s); js.id = id;''',
'            ||      ''js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.3&appId=668562893220980";''',
'            ||      ''fjs.parentNode.insertBefore(js, fjs);''',
'            ||  ''}(document, ''''script'''', ''''facebook-jssdk''''));</script>'';',
'',
'    sys.htp.p(l_html);',
'',
'    return l_result;',
'end render_facebook_comments;'))
,p_render_function=>'render_facebook_comments'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'2.0'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8942816315073512567)
,p_plugin_id=>wwv_flow_api.id(8941874312557712256)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Color Scheme'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'light'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(8942817721257513794)
,p_plugin_attribute_id=>wwv_flow_api.id(8942816315073512567)
,p_display_sequence=>10
,p_display_value=>'light'
,p_return_value=>'light'
,p_is_quick_pick=>true
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(8942828353963515139)
,p_plugin_attribute_id=>wwv_flow_api.id(8942816315073512567)
,p_display_sequence=>20
,p_display_value=>'dark'
,p_return_value=>'dark'
,p_is_quick_pick=>true
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8942611073998250162)
,p_plugin_id=>wwv_flow_api.id(8941874312557712256)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Number of comments on the page'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'10'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_help_text=>'The number of comments to show by default. The minimum value is 1.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8942830627227528302)
,p_plugin_id=>wwv_flow_api.id(8941874312557712256)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Sort by'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'social'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(8942831666280529316)
,p_plugin_attribute_id=>wwv_flow_api.id(8942830627227528302)
,p_display_sequence=>10
,p_display_value=>'Top'
,p_return_value=>'social'
,p_is_quick_pick=>true
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(8942832264321531805)
,p_plugin_attribute_id=>wwv_flow_api.id(8942830627227528302)
,p_display_sequence=>20
,p_display_value=>'Oldest'
,p_return_value=>'time'
,p_is_quick_pick=>true
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(8942832880438533237)
,p_plugin_attribute_id=>wwv_flow_api.id(8942830627227528302)
,p_display_sequence=>30
,p_display_value=>'Newest'
,p_return_value=>'reverse_time'
,p_is_quick_pick=>true
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8942612928279257144)
,p_plugin_id=>wwv_flow_api.id(8941874312557712256)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Width'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'100%'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_help_text=>'The width of the plugin. Either a pixel value or the literal 100% for fluid width. The mobile version of the Comments plugin ignores the width parameter, and instead has a fluid width of 100%.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(8942655931501118260)
,p_plugin_id=>wwv_flow_api.id(8941874312557712256)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Primary Key Item Name (On Current Page)'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_text_case=>'UPPER'
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
