<%inherit file="/layouts/config.mako"/>
<%!
    import os
    import datetime
    import sickbeard
    from sickbeard.common import SKIPPED, ARCHIVED, IGNORED, statusStrings, cpu_presets
    from sickbeard.sbdatetime import sbdatetime, date_presets, time_presets
    from sickbeard.helpers import anon_url
%>

<%block name="tabs">
    <li><a href="#misc">${_('Misc')}</a></li>
    <li><a href="#interface">${_('Interface')}</a></li>
    <li><a href="#advanced-settings">${_('Advanced Settings')}</a></li>
</%block>

<%block name="pages">
    <form id="configForm" action="saveGeneral" method="post">

        <!-- /misc //-->
        <div id="misc">
            <!-- Misc -->
            <div class="row">
                <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                    <div class="component-group-desc">
                        <h3>${_('Misc')}</h3>
                        <p>${_('Startup options. Indexer options. Log and show file locations.')}</p>
                        <p><b>${_('Some options may require a manual restart to take effect.')}</b></p>
                    </div>
                </div>
                <div class="col-lg-9 col-md-8 col-sm-8 col-xs-12">
                    <fieldset class="component-group-list">

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Default Indexer Language')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <select name="indexerDefaultLang" id="indexerDefaultLang" class="form-control form-control-inline input-sm input350 bfh-languages" data-language=${sickbeard.INDEXER_DEFAULT_LANGUAGE} data-available="${','.join(sickbeard.indexerApi().config['valid_languages'])}"></select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="indexerDefaultLang">${_('for adding shows and metadata providers')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Launch browser')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="launch_browser" id="launch_browser" ${('', 'checked="checked"')[bool(sickbeard.LAUNCH_BROWSER)]}/>
                                <label for="launch_browser">${_('open the SickRage home page on startup')}</label>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Initial page')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <select id="default_page" name="default_page" class="form-control input-sm input150">
                                            <option value="home" ${('', 'selected="selected"')[sickbeard.DEFAULT_PAGE == 'home']}>${_('Shows')}</option>
                                            <option value="schedule" ${('', 'selected="selected"')[sickbeard.DEFAULT_PAGE == 'schedule']}>${_('Schedule')}</option>
                                            <option value="history" ${('', 'selected="selected"')[sickbeard.DEFAULT_PAGE == 'history']}>${_('History')}</option>
                                            <option value="news" ${('', 'selected="selected"')[sickbeard.DEFAULT_PAGE == 'news']}>${_('News')}</option>
                                            <option value="IRC" ${('', 'selected="selected"')[sickbeard.DEFAULT_PAGE == 'IRC']}>${_('IRC')}</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="default_page">${_('when launching SickRage interface')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        ## Fix
                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Choose hour to update shows')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="number" min="0" max="23" step="1" name="showupdate_hour" id="showupdate_hour" value="${sickbeard.SHOWUPDATE_HOUR}" class="form-control input-sm input75" autocapitalize="off" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="showupdate_hour">${_('with information such as next air dates, show ended, etc. Use 15 for 3pm, 4 for 4am etc.')}</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label>${_('Note: minutes are randomized each time SickRage is started')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Send to trash for actions')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="checkbox" name="trash_remove_show" id="trash_remove_show" ${('', 'checked="checked"')[bool(sickbeard.TRASH_REMOVE_SHOW)]}/>
                                        <label for="trash_remove_show">${_('when using show "Remove" and delete files')}</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="checkbox" name="trash_rotate_logs" id="trash_rotate_logs" ${('', 'checked="checked"')[bool(sickbeard.TRASH_ROTATE_LOGS)]}/>
                                        <label for="trash_rotate_logs">${_('on scheduled deletes of the oldest log files')}</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <span>${_('selected actions use trash (recycle bin) instead of the default permanent delete')}</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Log file folder location')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="text" name="log_dir" id="log_dir" value="${sickbeard.ACTUAL_LOG_DIR}" class="form-control input-sm input250" autocapitalize="off"  title="log_dir"/>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Number of Log files saved')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="number" min="1" step="1" name="log_nr" id="log_nr" value="${sickbeard.LOG_NR}" class="form-control input-sm input75" autocapitalize="off" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="log_nr">${_('number of log files saved when rotating logs (default: 5) (REQUIRES RESTART)')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Size of Log files saved')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="number" min="0.5" step="0.1" name="log_size" id="log_size" value="${sickbeard.LOG_SIZE}" class="form-control input-sm input75" autocapitalize="off" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="log_size">${_('maximum size in MB of the log file (default: 1MB) (REQUIRES RESTART)')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Use initial indexer set to')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <select id="indexer_default" name="indexer_default" class="form-control input-sm input150">
                                            <option value="0" ${('', 'selected="selected"')[sickbeard.INDEXER_DEFAULT == 0]}>${_('All Indexers')}</option>
                                            % for indexer in sickbeard.indexerApi().indexers:
                                                <option value="${indexer}" ${('', 'selected="selected"')[sickbeard.INDEXER_DEFAULT == indexer]}>${sickbeard.indexerApi().indexers[indexer]}</option>
                                            % endfor
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="indexer_default">${_('as the default selection when adding new shows')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Timeout show indexer at')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="number" min="10" step="1" name="indexer_timeout" id="indexer_timeout" value="${sickbeard.INDEXER_TIMEOUT}" class="form-control input-sm input75" autocapitalize="off" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="indexer_timeout">${_('seconds of inactivity when finding new shows (default:20)')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Show root directories')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <span>${_('where the files of shows are located')}</span>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6 col-md-8 col-sm-12 col-xs-12">
                                        <%include file="/inc_rootDirs.mako"/>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <input type="submit" class="btn config_submitter" value="${_('Save Changes')}" />
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>

            <!-- Divider -->
            <div class="config-group-divider"></div>

            <!-- Updates -->
            <div class="row">
                <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                    <div class="component-group-desc">
                        <h3>${_('Updates')}</h3>
                        <p>${_('Options for software updates.')}</p>
                    </div>
                </div>
                <div class="col-lg-9 col-md-8 col-sm-8 col-xs-12">
                    <fieldset class="component-group-list">

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Check software updates')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="version_notify" id="version_notify" ${('', 'checked="checked"')[bool(sickbeard.VERSION_NOTIFY)]}/>
                                <label for="version_notify">${_('''and display notifications when updates are available. Checks are run on startup and at the frequency set below*''')}</label>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Automatically update')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="auto_update" id="auto_update" ${('', 'checked="checked"')[bool(sickbeard.AUTO_UPDATE)]}/>
                                <label for="auto_update">${_('''fetch and install software updates. Updates are run on startup and in the background at the frequency set below*''')}</label>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Check the server every*')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="number" min="1" step="1" name="update_frequency" id="update_frequency" value="${sickbeard.UPDATE_FREQUENCY}" class="form-control input-sm input75" autocapitalize="off" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="update_frequency">${_('hours for software updates (default:1)')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Notify on software update')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="notify_on_update" id="notify_on_update" ${('', 'checked="checked"')[bool(sickbeard.NOTIFY_ON_UPDATE)]}/>
                                <label for="notify_on_update">${_('send a message to all enabled notifiers when SickRage has been updated')}</label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <input type="submit" class="btn config_submitter" value="${_('Save Changes')}" />
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>
        </div>

        <!-- /interface //-->
        <div id="interface">
            <!-- User Interface -->
            <div class="row">
                <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                    <div class="component-group-desc">
                        <h3>${_('User Interface')}</h3>
                        <p>${_('Options for visual appearance.')}</p>
                    </div>
                </div>
                <div class="col-lg-9 col-md-8 col-sm-8 col-xs-12">

                    <fieldset class="component-group-list">

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Interface Language')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <select id="gui_language" name="gui_language" class="form-control input-sm input250">
                                            <option value="" ${('', 'selected="selected"')[sickbeard.GUI_LANG == ""]}>${_('System Language')}</option>
                                            % for lang in [language for language in os.listdir(sickbeard.LOCALE_DIR) if '_' in language]:
                                                <option value="${lang}" ${('', 'selected="selected"')[sickbeard.GUI_LANG == lang]}>${lang}</option>
                                            % endfor
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="gui_language" class="red-text">${_('for appearance to take effect, save then refresh your browser')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Display theme')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <select id="theme_name" name="theme_name" class="form-control input-sm input250">
                                            <option value="dark" ${('', 'selected="selected"')[sickbeard.THEME_NAME == 'dark']}>${_('Dark')}</option>
                                            <option value="light" ${('', 'selected="selected"')[sickbeard.THEME_NAME == 'light']}>${_('Light')}</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="theme_name" class="red-text">${_('for appearance to take effect, save then refresh your browser')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Show fanart in the background')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" class="enabler" name="fanart_background" id="fanart_background" ${('', 'checked="checked"')[bool(sickbeard.FANART_BACKGROUND)]}>
                                <label for="fanart_background">${_('on the show summary page')}</label>
                            </div>
                        </div>

                        <div id="content_fanart_background">

                            <div class="field-pair row">
                                <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                    <label class="component-title">${_('Fanart transparency')}</label>
                                </div>
                                <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <input type="number" step="0.1" min="0.1" max="1.0" name="fanart_background_opacity" id="fanart_background_opacity" value="${sickbeard.FANART_BACKGROUND_OPACITY}" class="form-control input-sm input75" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label for="fanart_background_opacity" class="component-desc">${_('Transparency of the fanart in the background')}</label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Show all seasons')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="display_all_seasons" id="display_all_seasons" ${('', 'checked="checked"')[bool(sickbeard.DISPLAY_ALL_SEASONS)]}>
                                <label for="display_all_seasons">${_('on the show summary page')}</label>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Sort with "The", "A", "An"')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="sort_article" id="sort_article" ${('', 'checked="checked"')[bool(sickbeard.SORT_ARTICLE)]}/>
                                <label for="sort_article">${_('include articles ("The", "A", "An") when sorting show lists')}</label>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Missed episodes range')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="number" step="1" min="7" name="coming_eps_missed_range" id="coming_eps_missed_range" value="${sickbeard.COMING_EPS_MISSED_RANGE}" class="form-control input-sm input75" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="coming_eps_missed_range">${_('Set the range in days of the missed episodes in the Schedule page')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Display fuzzy dates')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="fuzzy_dating" id="fuzzy_dating" class="viewIf datePresets" ${('', 'checked="checked"')[bool(sickbeard.FUZZY_DATING)]}/>
                                <label for="fuzzy_dating">${_('move absolute dates into tooltips and display e.g. "Last Thu", "On Tue"')}</label>
                            </div>
                        </div>

                        <div class="field-pair row show_if_fuzzy_dating ${(' metadataDiv', '')[not bool(sickbeard.FUZZY_DATING)]}">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Trim zero padding')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="trim_zero" id="trim_zero" ${('', 'checked="checked"')[bool(sickbeard.TRIM_ZERO)]}/>
                                <label for="trim_zero">${_('remove the leading number "0" shown on hour of day, and date of month')}</label>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Date style')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <select class="form-control input-sm input250 ${(' metadataDiv', '')[bool(sickbeard.FUZZY_DATING)]}" id="date_presets${('_na', '')[bool(sickbeard.FUZZY_DATING)]}" name="date_preset${('_na', '')[bool(sickbeard.FUZZY_DATING)]}">
                                    % for cur_preset in date_presets:
                                        <option value="${cur_preset}" ${('', 'selected="selected"')[sickbeard.DATE_PRESET == cur_preset or ("%x" == sickbeard.DATE_PRESET and cur_preset == '%a, %b %d, %Y')]}>${datetime.datetime(datetime.datetime.now().year, 12, 31, 14, 30, 47).strftime(cur_preset)}</option>
                                    % endfor
                                </select>
                                <select class="form-control input-sm input250 ${(' metadataDiv', '')[not bool(sickbeard.FUZZY_DATING)]}" id="date_presets${(' metadataDiv', '')[not bool(sickbeard.FUZZY_DATING)]}" name="date_preset${('_na', '')[not bool(sickbeard.FUZZY_DATING)]}">
                                    <option value="%x" ${('', 'selected="selected"')[sickbeard.DATE_PRESET == '%x']}>${_('Use System Default')}</option>
                                    % for cur_preset in date_presets:
                                        <option value="${cur_preset}" ${('', 'selected="selected"')[sickbeard.DATE_PRESET == cur_preset]}>${datetime.datetime(datetime.datetime.now().year, 12, 31, 14, 30, 47).strftime(cur_preset)}</option>
                                    % endfor
                                </select>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Time style')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <select id="time_presets" name="time_preset" class="form-control input-sm input250">
                                            % for cur_preset in time_presets:
                                                <option value="${cur_preset}" ${('', 'selected="selected"')[sickbeard.TIME_PRESET_W_SECONDS == cur_preset]}>${sbdatetime.now().sbftime(show_seconds=True, t_preset=cur_preset)}</option>
                                            % endfor
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="time_presets"><b>${_('Note')}:</b> ${_('seconds are only shown on the History page')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Timezone')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <label for="local" class="space-right">
                                    <input type="radio" name="timezone_display" id="local" value="local" ${('', 'checked="checked"')[sickbeard.TIMEZONE_DISPLAY == "local"]} />${_('Local')}
                                </label>
                                <label for="network">
                                    <input type="radio" name="timezone_display" id="network" value="network" ${('', 'checked="checked"')[sickbeard.TIMEZONE_DISPLAY == "network"]} />${_('Network')}
                                </label>
                                <div class="clear-left">
                                    <p>${_('display dates and times in either your timezone or the shows network timezone')}</p>
                                </div>
                                <div class="clear-left">
                                    <p><b>${_('Note')}:</b> ${_('Use local timezone to start searching for episodes minutes after show ends (depends on your dailysearch frequency)')}</p>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Download url')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <input class="form-control input350" type="text" name="download_url" id="download_url" value="${sickbeard.DOWNLOAD_URL}" size="35" autocapitalize="off" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="download_url" class="component-desc">${_('URL where the shows can be downloaded.')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <input type="submit" class="btn config_submitter" value="${_('Save Changes')}" />
                            </div>
                        </div>

                    </fieldset>
                </div>
            </div>

            <!-- Divider -->
            <div class="config-group-divider"></div>

            <!-- Web Interface -->
            <div class="row">
                <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                    <div class="component-group-desc">
                        <h3>${_('Web Interface')}</h3>
                        <p>${_('It is recommended that you enable a username and password to secure SickRage from being tampered with remotely.')}</p>
                        <p><b>${_('These options require a manual restart to take effect.')}</b></p>
                    </div>
                </div>
                <div class="col-lg-9 col-md-8 col-sm-8 col-xs-12">
                    <fieldset class="component-group-list">

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('API key')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="text" name="api_key" id="api_key" value="${sickbeard.API_KEY}" class="form-control input-sm input300" readonly="readonly" autocapitalize="off" />
                                        <input class="btn btn-inline" type="button" id="generate_new_apikey" value="Generate">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="api_key">${_('used to give 3rd party programs limited access to SickRage')}</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label>${_('you can try all the features of the API')} <a href="${srRoot}/apibuilder/">${_('here')}</a></label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('HTTP logs')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="web_log" id="web_log" ${('', 'checked="checked"')[bool(sickbeard.WEB_LOG)]}/>
                                <p>${_('enable logs from the internal Tornado web server')}</p>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('HTTP username')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="text" name="web_username" id="web_username" value="${sickbeard.WEB_USERNAME}" class="form-control input-sm input300" autocapitalize="off" autocomplete="no" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label>${_('set blank for no login')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('HTTP password')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="password" name="web_password" id="web_password" value="${sickbeard.WEB_PASSWORD}" class="form-control input-sm input300" autocomplete="no" autocapitalize="off"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="web_password">${_('blank = no authentication')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('HTTP port')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="number" min="1" step="1" name="web_port" id="web_port" value="${sickbeard.WEB_PORT}" class="form-control input-sm input100" autocapitalize="off" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="web_port">${_('web port to browse and access SickRage (default:8081)')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Notify on login')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="notify_on_login" class="enabler" id="notify_on_login" ${('', 'checked="checked"')[bool(sickbeard.NOTIFY_ON_LOGIN)]}/>
                                <label for="notify_on_login">${_('enable to be notified when a new login happens in webserver')}</label>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Listen on IPv6')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="web_ipv6" id="web_ipv6" ${('', 'checked="checked"')[bool(sickbeard.WEB_IPV6)]}/>
                                <label for="web_ipv6">${_('attempt binding to any available IPv6 address')}</label>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Enable HTTPS')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="enable_https" class="enabler" id="enable_https" ${('', 'checked="checked"')[bool(sickbeard.ENABLE_HTTPS)]}/>
                                <label for="enable_https">${_('enable access to the web interface using a HTTPS address')}</label>
                            </div>
                        </div>

                        <div id="content_enable_https">

                            <div class="field-pair row">
                                <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                    <label class="component-title">${_('HTTPS certificate')}</label>
                                </div>
                                <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                    <input type="text" name="https_cert" id="https_cert" value="${sickbeard.HTTPS_CERT}" class="form-control input-sm input300" autocapitalize="off" />
                                    <label for="https_cert">${_('file name or path to HTTPS certificate')}</label>
                                </div>
                            </div>

                            <div class="field-pair row">
                                <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                    <label class="component-title">${_('HTTPS key')}</label>
                                </div>
                                <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                    <input type="text" name="https_key" id="https_key" value="${sickbeard.HTTPS_KEY}" class="form-control input-sm input300" autocapitalize="off" />
                                    <label for="https_key">${_('file name or path to HTTPS key')}</label>
                                </div>
                            </div>

                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Reverse proxy headers')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="handle_reverse_proxy" id="handle_reverse_proxy" ${('', 'checked="checked"')[bool(sickbeard.HANDLE_REVERSE_PROXY)]}/>
                                <label for="handle_reverse_proxy">${_('accept the following reverse proxy headers (advanced)...<br>(X-Forwarded-For, X-Forwarded-Host, and X-Forwarded-Proto)')}</label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <input type="submit" class="btn config_submitter" value="${_('Save Changes')}" />
                            </div>
                        </div>

                    </fieldset>
                </div>
            </div>
        </div>

        <!-- /advanced settings //-->
        <div id="advanced-settings">

            <!-- Advanced Settings -->
            <div class="row">
                <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                    <div class="component-group-desc">
                        <h3>${_('Advanced Settings')}</h3>
                    </div>
                </div>
                <div class="col-lg-9 col-md-8 col-sm-8 col-xs-12">
                    <fieldset class="component-group-list">

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('CPU throttling')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <select id="cpu_presets" name="cpu_preset" class="form-control input-sm input250">
                                            % for cur_preset in cpu_presets:
                                                <option value="${cur_preset}" ${('', 'selected="selected"')[sickbeard.CPU_PRESET == cur_preset]}>${cur_preset.capitalize()}</option>
                                            % endfor
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="cpu_presets">${_('Normal (default). High is lower and Low is higher CPU use')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Anonymous redirect')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="text" name="anon_redirect" value="${sickbeard.ANON_REDIRECT}" class="form-control input-sm input300" autocapitalize="off" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="anon_redirect">${_('backlink protection via anonymizer service, must end in "?"')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Enable debug')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="debug" id="debug" ${('', 'checked="checked"')[bool(sickbeard.DEBUG)]}/>
                                <label for="debug">${_('Enable debug logs')}</label>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Verify SSL Certs')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="ssl_verify" id="ssl_verify" ${('', 'checked="checked"')[bool(sickbeard.SSL_VERIFY)]}/>
                                <label for="ssl_verify">${_('Verify SSL Certificates (Disable this for broken SSL installs (Like QNAP))')}</label>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('No Restart')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="no_restart" id="no_restart" ${('', 'checked="checked"')[bool(sickbeard.NO_RESTART)]}/>
                                <label for="no_restart">${_('''Only shutdown when restarting SR. Only select this when you have external software restarting SR automatically when it stops (like FireDaemon)''')}</label>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Encrypt passwords')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="encryption_version" id="encryption_version" ${('', 'checked="checked"')[bool(sickbeard.ENCRYPTION_VERSION)]}/>
                                <label for="encryption_version">${_('in the <code>config.ini</code> file.')}
                                    <b>${_('Warning')}:</b> ${_('Passwords must only contain')}
                                    <a target="_blank" href="${anon_url('http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters')}">${_('ASCII characters')}</a>
                                </label>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Unprotected calendar')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="calendar_unprotected" id="calendar_unprotected" ${('', 'checked="checked"')[bool(sickbeard.CALENDAR_UNPROTECTED)]}/>
                                <label for="calendar_unprotected">${_('''allow subscribing to the calendar without user and password. Some services like Google Calendar only work this way''')}</label>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Google Calendar Icons')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="calendar_icons" id="calendar_icons" ${('', 'checked="checked"')[bool(sickbeard.CALENDAR_ICONS)]}/>
                                <label for="calendar_icons">${_('show an icon next to exported calendar events in Google Calendar.')}</label>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Proxy host')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="text" name="proxy_setting" value="${sickbeard.PROXY_SETTING}" class="form-control input-sm input300" autocapitalize="off" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="proxy_setting">${_('blank to disable or proxy to use when connecting to providers')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Skip Remove Detection')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="skip_removed_files" id="skip_removed_files" ${('', 'checked="checked"')[bool(sickbeard.SKIP_REMOVED_FILES)]}/>
                                <label for="skip_removed_files">${_('Skip detection of removed files. If disabled the episode will be set to the default deleted status')}</label>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Default deleted episode status')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        % if not sickbeard.SKIP_REMOVED_FILES:
                                            <select name="ep_default_deleted_status" id="ep_default_deleted_status" class="form-control input-sm input250" title="Default delete status">
                                                % for defStatus in [SKIPPED, IGNORED, ARCHIVED]:
                                                    <option value="${defStatus}" ${('', 'selected="selected"')[int(sickbeard.EP_DEFAULT_DELETED_STATUS) == defStatus]}>${statusStrings[defStatus]}</option>
                                                % endfor
                                            </select>
                                        % else:
                                            <select name="ep_default_deleted_status" id="ep_default_deleted_status" class="form-control input-sm input250" disabled="disabled" title="Default delete status">
                                                % for defStatus in [SKIPPED, IGNORED]:
                                                    <option value="${defStatus}" ${('', 'selected="selected"')[sickbeard.EP_DEFAULT_DELETED_STATUS == defStatus]}>${statusStrings[defStatus]}</option>
                                                % endfor
                                            </select>
                                            <input type="hidden" name="ep_default_deleted_status" value="${sickbeard.EP_DEFAULT_DELETED_STATUS}" />
                                        % endif
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="ep_default_deleted_status">${_('Define the status to be set for media file that has been deleted.')}</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label><b>${_('Note')}:</b> ${_('Archived option will keep previous downloaded quality')}</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label>${_('Example: Downloaded (1080p WEB-DL) ==> Archived (1080p WEB-DL)')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <input type="submit" class="btn config_submitter" value="${_('Save Changes')}" />
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>

            <!-- Divider -->
            <div class="config-group-divider"></div>

            <!-- Github -->
            <div class="row">
                <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                    <div class="component-group-desc">
                        <h3>GitHub</h3>
                        <p>${_('Options for github related features.')}</p>
                    </div>
                </div>
                <div class="col-lg-9 col-md-8 col-sm-8 col-xs-12">

                    <fieldset class="component-group-list">

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Branch version')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <select id="branchVersion" class="form-control form-control-inline input-sm pull-left" title="Branch Version">
                                            <% gh_branch = sickbeard.versionCheckScheduler.action.list_remote_branches() %>
                                            % if gh_branch:
                                                % for cur_branch in gh_branch:
                                                    % if sickbeard.GIT_USERNAME and sickbeard.GIT_PASSWORD and sickbeard.DEVELOPER == 1:
                                                        <option value="${cur_branch}" ${('', 'selected="selected"')[sickbeard.BRANCH == cur_branch]}>${cur_branch}</option>
                                                    % elif sickbeard.GIT_USERNAME and sickbeard.GIT_PASSWORD and cur_branch in ['master', 'develop']:
                                                        <option value="${cur_branch}" ${('', 'selected="selected"')[sickbeard.BRANCH == cur_branch]}>${cur_branch}</option>
                                                    % elif cur_branch == 'master':
                                                        <option value="${cur_branch}" ${('', 'selected="selected"')[sickbeard.BRANCH == cur_branch]}>${cur_branch}</option>
                                                    % endif
                                                % endfor
                                            % endif
                                        </select>
                                        % if not gh_branch:
                                            <input class="btn btn-inline" style="margin-left: 6px;" type="button" id="branchCheckout" value="Checkout Branch" disabled>
                                        % else:
                                            <input class="btn btn-inline" style="margin-left: 6px;" type="button" id="branchCheckout" value="Checkout Branch">
                                        % endif
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        % if not gh_branch:
                                            <div class="clear-left" style="color:#FF0000"><p>${_('Error: No branches found.')}</p></div>
                                        % else:
                                            <div class="clear-left"><p>${_('select branch to use (restart required)')}</p></div>
                                        % endif
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('GitHub username')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="text" name="git_username" id="git_username" value="${sickbeard.GIT_USERNAME}" class="form-control input-sm input300" autocapitalize="off" autocomplete="no" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="git_username">${_('*** (REQUIRED FOR SUBMITTING ISSUES) ***')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('GitHub password')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="password" name="git_password" id="git_password" value="${sickbeard.GIT_PASSWORD}" class="form-control input-sm input300" autocomplete="no" autocapitalize="off" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="git_password">${_('*** (REQUIRED FOR SUBMITTING ISSUES) ***')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('GitHub remote for branch')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="text" name="git_remote" id="git_remote" value="${sickbeard.GIT_REMOTE}" class="form-control input-sm input300" autocapitalize="off" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="git_remote">${_('default:origin. Access repo configured remotes (save then refresh browser)')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row">
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Git executable path')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <div class="row">
                                    <div class="col-md-12">
                                        <input type="text" id="git_path" name="git_path" value="${sickbeard.GIT_PATH}" class="form-control input-sm input300" autocapitalize="off" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="git_path">${_('only needed if OS is unable to locate git from env')}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="field-pair row" hidden>
                            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-12">
                                <label class="component-title">${_('Git reset')}</label>
                            </div>
                            <div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 component-desc">
                                <input type="checkbox" name="git_reset" id="git_reset" ${('', 'checked="checked"')[bool(sickbeard.GIT_RESET)]}/>
                                <label for="git_reset">${_('removes untracked files and performs a hard reset on git branch automatically to help resolve update issues')}</label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <input type="submit" class="btn config_submitter" value="${_('Save Changes')}" />
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>

        </div>

    </form>
</%block>
