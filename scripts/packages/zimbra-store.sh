#!/bin/bash
#
# ***** BEGIN LICENSE BLOCK *****
# Zimbra Collaboration Suite Server
# Copyright (C) 2009, 2010, 2011, 2013, 2014, 2015, 2016 Synacor, Inc.
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software Foundation,
# version 2 of the License.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program.
# If not, see <https://www.gnu.org/licenses/>.
# ***** END LICENSE BLOCK *****

# Shell script to create zimbra store package


#-------------------- Configuration ---------------------------

    currentScript=`basename $0 | cut -d "." -f 1`                          # zimbra-store
    currentPackage=`echo ${currentScript}build | cut -d "-" -f 2` # storebuild

    jettyVersion=jetty-distribution-9.3.5.v20151012


#-------------------- Build Package ---------------------------

    echo -e "\tCreate package directories" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/etc/sudoers.d
    mkdir -p ${repoDir}/zm-build/${currentPackage}/DEBIAN
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/bin
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf/templates

    echo -e "\tCopy package files" >> ${buildLogFile}

    echo -e "\tCopy etc files" >> ${buildLogFile}
    cp ${repoDir}/zm-build/rpmconf/Env/sudoers.d/02_${currentScript} ${repoDir}/zm-build/${currentPackage}/etc/sudoers.d/02_${currentScript}
    cat ${repoDir}/zm-build/rpmconf/Spec/Scripts/${currentScript}.post >> ${repoDir}/zm-build/${currentPackage}/DEBIAN/postinst
    chmod 555 ${repoDir}/zm-build/${currentPackage}/DEBIAN/*

    echo -e "\tCopy bin files of /opt/zimbra/" >> ${buildLogFile}
    cp -f ${repoDir}/zm-hsm/src/bin/zmhsm ${repoDir}/zm-build/${currentPackage}/opt/zimbra/bin/zmhsm
    cp -f ${repoDir}/zm-archive-utils/src/bin/zmarchiveconfig ${repoDir}/zm-build/${currentPackage}/opt/zimbra/bin/zmarchiveconfig
    cp -f ${repoDir}/zm-archive-utils/src/bin/zmarchivesearch ${repoDir}/zm-build/${currentPackage}/opt/zimbra/bin/zmarchivesearch
    cp -f ${repoDir}/zm-sync-tools/src/bin/zmsyncreverseproxy ${repoDir}/zm-build/${currentPackage}/opt/zimbra/bin/zmsyncreverseproxy
    cp -f ${repoDir}/zm-sync-store/src/bin/zmdevicesstats ${repoDir}/zm-build/${currentPackage}/opt/zimbra/bin/zmdevicesstats
    cp -f ${repoDir}/zm-sync-store/src/bin/zmgdcutil ${repoDir}/zm-build/${currentPackage}/opt/zimbra/bin/zmgdcutil

    echo -e "\tCopy conf files of /opt/zimbra/" >> ${buildLogFile}
    cp -f ${repoDir}/zm-store-conf/conf/globs2 ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf
    cp -f ${repoDir}/zm-store-conf/conf/magic ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf
    cp -f ${repoDir}/zm-store-conf/conf/magic.zimbra ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf
    cp -f ${repoDir}/zm-store-conf/conf/globs2.zimbra ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf
    cp -f ${repoDir}/zm-store-conf/conf/spnego_java_options.in ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf
    cp -f ${repoDir}/zm-store-conf/conf/contacts/zimbra-contact-fields.xml ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf/zimbra-contact-fields.xml
    cp -f ${repoDir}/zm-windows-comp/ZimbraMigrationTools/zmztozmig.conf ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf/zmztozmig.conf
    cp -f ${repoDir}/zm-ews-store/resources/jaxb-bindings.xml ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf
    cp -rf ${repoDir}/zm-web-client/WebRoot/templates/* ${repoDir}/zm-build/${currentPackage}/opt/zimbra/conf/templates

    echo -e "\tCopy extensions-extra files of /op/zimbra/" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/extensions-extra/openidconsumer
    cp -rf ${repoDir}/zm-openid-consumer-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/extensions-extra/openidconsumer


    echo -e "\tCopy extensions-network-extra files of /op/zimbra/" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/extensions-network-extra
    cp -rf ${repoDir}/zm-saml-consumer-store/build/dist/saml ${repoDir}/zm-build/${currentPackage}/opt/zimbra/extensions-network-extra/

    echo -e "\tCopy ${jettyVersion} files of /op/zimbra/" >> ${buildLogFile}


    echo -e "\tCopy lib files of /opt/zimbra/" >> ${buildLogFile}

    echo -e "\t\tCopy ext files of /opt/zimbra/lib/" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib
    cp -f ${repoDir}/zm-libnative/build/dist/libsetuid.so ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/
    cp -f ${repoDir}/zm-libnative/build/dist/libzimbra-native.so ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/

    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/backup
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-archive
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/voice
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/cisco
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/mitel
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/network
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/com_zimbra_oo
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/convertd
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/clamscanner
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/twofactorauth
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/nginx-lookup
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/openidconsumer
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-license
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-freebusy
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbraadminversioncheck
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbrahsm
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbraldaputils
    cp -rf ${repoDir}/zm-backup-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/backup
    cp -rf ${repoDir}/zm-archive-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-archive
    cp -rf ${repoDir}/zm-voice-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-voice-store
    cp -rf ${repoDir}/zm-voice-cisco-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-voice-cisco-store
    cp -rf ${repoDir}/zm-voice-mitel-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-voice-mitel-store
    cp -rf ${repoDir}/zm-ews-stub/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbraews
    cp -rf ${repoDir}/zm-ews-common/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbraews
    cp -rf ${repoDir}/zm-ews-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbraews
    cp -rf ${repoDir}/zm-sync-common/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbrasync
    cp -rf ${repoDir}/zm-sync-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbrasync
    cp -rf ${repoDir}/zm-sync-tools/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbrasync
    cp -f ${repoDir}/zm-openoffice-store/build/dist/zm-openoffice-store*.jar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/com_zimbra_oo/com_zimbra_oo.jar
    cp -rf ${repoDir}/zm-network-store/build/dist/*.jar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/network
    cp -rf ${repoDir}/zm-convertd-store/build/dist/*jar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/convertd
    cp -f ${repoDir}/zm-clam-scanner-store/build/dist/zm-clam-scanner-store*.jar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/clamscanner
    cp -f ${repoDir}/zm-twofactorauth-store/build/dist/zm-twofactorauth-store*.jar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/twofactorauth
    cp -f ${repoDir}/zm-nginx-lookup-store/build/dist/zm-nginx-lookup-store*.jar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/nginx-lookup
    cp -f ${repoDir}/zm-openid-consumer-store/build/dist/guice*.jar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/openidconsumer/
    cp -f ${repoDir}/zm-license-store/build/dist/zm-license-store*.jar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-license/
    cp -rf ${repoDir}/zm-backup-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/backup
    cp -rf ${repoDir}/zm-archive-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-archive
    cp -rf ${repoDir}/zm-voice-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-voice-store
    cp -rf ${repoDir}/zm-voice-cisco-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-voice-cisco-store
    cp -rf ${repoDir}/zm-voice-mitel-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-voice-mitel-store
    cp -rf ${repoDir}/zm-ews-stub/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbraews
    cp -rf ${repoDir}/zm-ews-common/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbraews
    cp -rf ${repoDir}/zm-ews-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbraews
    cp -rf ${repoDir}/zm-sync-common/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbrasync
    cp -rf ${repoDir}/zm-sync-store/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbrasync
    cp -rf ${repoDir}/zm-sync-tools/build/dist ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbrasync
    cp -f ${repoDir}/zm-freebusy-provider-store/build/zimbra-freebusyprovider.jar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbra-freebusy/zimbra-freebusyprovider.jar
    cp -f ${repoDir}/zm-versioncheck-store/build/zm-versioncheck-store*.jar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbraadminversioncheck/zimbraadminversioncheck.jar
    cp -f ${repoDir}/zm-hsm-store/build/zimbrahsm.jar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbrahsm/zimbrahsm.jar
    cp -f ${repoDir}/zm-ldap-utils-store/build/zm-ldap-utils-store-8.8.0.1470081257.jar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext/zimbraldaputils/zimbraldaputils.jar


#-------------------- Get wars content (service.war, zimbra.war and zimbraAdmin.war) ---------------------------

    echo "\t\t++++++++++ service.war content ++++++++++" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/service
    cd ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/service; jar -xf ${repoDir}/zm-store/build/dist/service.war

    echo "\t\t***** zimbra.tld content *****" >> ${buildLogFile}
    cp ${repoDir}/zm-zimlets/conf/zimbra.tld ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/service/WEB-INF


    echo "\t\t++++++++++ zimbra.war content ++++++++++" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra
    cd ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra; jar -xf ${repoDir}/zm-web-client/build/dist/jetty/webapps/zimbra.war

    echo "\t\t***** css, public and t content *****" >> ${buildLogFile}
    cp ${repoDir}/zm-touch-client/build/WebRoot/css/ztouch.css ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/css
    cp ${repoDir}/zm-touch-client/build/WebRoot/public/loginTouch.jsp ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/public
    cp -rf ${repoDir}/zm-touch-client/build/WebRoot/t ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/t
    cp -rf ${repoDir}/zm-touch-client/build/WebRoot/tdebug ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/tdebug

    echo "\t\t***** help content *****" >> ${buildLogFile}
    cp -rf ${repoDir}/zm-help/. ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/help

    echo "\t\t***** portals example content *****" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/portals/example
    cp -rf ${repoDir}/zm-webclient-portal-example/example ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/portals

    echo "\t\t***** downloads content *****" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/downloads
    cp -rf ${repoDir}/zm-downloads/. ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/downloads

    echo "\t\t***** robots.txt content *****" >> ${buildLogFile}
    cp -rf ${repoDir}/zm-aspell/conf/robots.txt ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra


    echo "\t\t++++++++++ zimbraAdmin.war content ++++++++++" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbraAdmin
    cd ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbraAdmin; jar -xf ${repoDir}/zm-admin-console/build/dist/jetty/webapps/zimbraAdmin.war

    echo "\t\t***** help content *****" >> ${buildLogFile}
    cp -rf ${repoDir}/zm-help/. ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbraAdmin/help

    echo "\t\t***** img content *****" >> ${buildLogFile}
    cp -rf ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/img/animated ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbraAdmin/img
    cp -rf ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/img/dwt ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbraAdmin/img
    declare -a imgArray=("arrows.png" "deprecated.gif" "deprecated2.gif" "deprecated3.gif" "docelements.gif" "docquicktables.gif" \
                         "dwt.gif" "dwt.png" "flags.png" "large.png" "mail.png" "oauth.png" "offline.gif" "offline.png" "offline2.gif" "partners.png" "startup.png" "table.png" "voicemail.gif" "voicemail.png")
    for i in "${imgArray[@]}"
    do
        cp ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/img/${i} ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbraAdmin/img
    done

    echo "\t\t***** public content *****" >> ${buildLogFile}
    cp -rf ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/public/flash ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbraAdmin/public
    cp ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/public/jsp/TinyMCE.jsp ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbraAdmin/public/jsp
    cp ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/public/jsp/XForms.jsp ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbraAdmin/public/jsp
    cp -rf ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/public/proto ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbraAdmin/public
    cp -rf ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/public/sounds ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbraAdmin/public
    cp -rf ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/public/tmp ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbraAdmin/public
    declare -a jspArray=("access.jsp" "authorize.jsp" "launchSidebar.jsp" "setResourceBundle.jsp" "TwoFactorSetup.jsp")
    for i in "${jspArray[@]}"
    do
        cp ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/public/${i} ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbraAdmin/public
    done

    echo "\t\t***** templates content *****" >> ${buildLogFile}
    cp -rf ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/templates/abook ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbraAdmin/templates
    cp -rf ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/templates/calendar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbraAdmin/templates

    echo "\t\t***** messages content *****" >> ${buildLogFile}
    declare -a messagesArray=("ZbMsg*.properties" "ZhMsg*.properties" "ZmMsg*.properties" "ZMsg*.properties" "ZmSMS*.properties" "ZtMsg*.properties" "AjxTemplateMsg*.properties")
    for i in "${messagesArray[@]}"
    do
        cp -rf ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbra/WEB-INF/classes/messages/${i} ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/webapps/zimbraAdmin/WEB-INF/classes/messages
    done

    echo -e "\t\tCopy work folder of zm-web-client build to /opt/zimbra/jetty/" >> ${buildLogFile}
    cp -rf ${repoDir}/zm-web-client/build/dist/jetty/work ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/

    echo -e "\t\tCopy ext-common files of /opt/zimbra/lib/" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext-common
    cp -f ${repoDir}/zm-xmbxsearch-store/build/dist/*.jar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/ext-common/zimbracmbsearch.jar

    echo -e "\t\tCopy jars files of /opt/zimbra/lib/" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/jars
    cp -f ${repoDir}/zm-milter/build/dist/zm-milter*.jar  ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/jars/
    cp -f ${repoDir}/zm-windows-comp/ZimbraMigrationTools/jars/zmzimbratozimbramig.jar ${repoDir}/zm-build/${currentPackage}/opt/zimbra/lib/jars/zmzimbratozimbramig.jar

    echo -e "\tCopy libexec files of /opt/zimbra/" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/libexec
    cp -f ${repoDir}/zm-windows-comp/ZimbraMigrationTools/src/libexec/zmztozmig ${repoDir}/zm-build/${currentPackage}/opt/zimbra/libexec
    cp -f ${repoDir}/zm-windows-comp/ZimbraMigrationTools/src/libexec/zmcleaniplanetics ${repoDir}/zm-build/${currentPackage}/opt/zimbra/libexec
    cp -f ${repoDir}/zm-versioncheck-utilities/src/libexec/zmcheckversion ${repoDir}/zm-build/${currentPackage}/opt/zimbra/libexec

    echo -e "\tCopy log files of /opt/zimbra/" >> ${buildLogFile}


    echo -e "\tCopy zimlets files of /opt/zimbra/" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/zimlets
    zimletsArray=( "zm-versioncheck-admin-zimlet" \
                   "zm-bulkprovision-admin-zimlet" \
                   "zm-certificate-manager-admin-zimlet" \
                   "zm-clientuploader-admin-zimlet" \
                   "zm-proxy-config-admin-zimlet" \
                   "zm-helptooltip-zimlet" \
                   "zm-viewmail-admin-zimlet" )
    for i in "${zimletsArray[@]}"
    do
        cp ${repoDir}/${i}/build/zimlet/*.zip ${repoDir}/zm-build/${currentPackage}/opt/zimbra/zimlets
    done

    cp -f ${repoDir}/zm-zimlets/build/dist/zimlets/*.zip ${repoDir}/zm-build/${currentPackage}/opt/zimbra/zimlets

    echo -e "\tCopy zimlets-network files of /opt/zimbra/" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/zimlets-network
    adminZimlets=( "zm-license-admin-zimlet" \
                   "zm-backup-restore-admin-zimlet" \
                   "zm-convertd-admin-zimlet" \
                   "zm-delegated-admin-zimlet" \
                   "zm-hsm-admin-zimlet" \
                   "zm-smime-applet" \
                   "zm-smime-cert-admin-zimlet" \
                   "zm-2fa-admin-zimlet" \
                   "zm-ucconfig-admin-zimlet" \
                   "zm-mobile-sync-admin-zimlet" )
    for i in "${adminZimlets[@]}"
    do
        cp ${repoDir}/${i}/build/zimlet/*.zip ${repoDir}/zm-build/${currentPackage}/opt/zimbra/zimlets-network
    done

    adminUcZimlets=( "cisco" "mitel" "voiceprefs" )
    for i in "${adminUcZimlets[@]}"
    do
        cp ${repoDir}/zm-uc-admin-zimlets/${i}/build/zimlet/*.zip ${repoDir}/zm-build/${currentPackage}/opt/zimbra/zimlets-network
    done

    echo "\t\t***** Building jetty/common/ *****" >> ${buildLogFile}
    
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/common/lib
    
    zimbrapatchedjars=("ant-1.7.0-ziputil-patched.jar" "ical4j-0.9.16-patched.jar" "nekohtml-1.9.13.1z.jar");
    for i in "${zimbrapatchedjars[@]}"
    do
        cp ${repoDir}/zm-zcs-lib/build/dist/${i} ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/common/lib
    done
    
    thirdpartyjars=("apache-log4j-extras-1.0.jar" "bcprov-jdk15-1.46.jar" "commons-cli-1.2.jar" "commons-codec-1.7.jar" "commons-collections-3.2.2.jar" "commons-compress-1.10.jar" "commons-dbcp-1.4.jar" \
        "commons-fileupload-1.2.2.jar" "commons-httpclient-3.1.jar" "commons-io-1.4.jar" "commons-lang-2.6.jar" "commons-logging-1.1.1.jar" "commons-net-3.3.jar" \
        "commons-pool-1.6.jar" "concurrentlinkedhashmap-lru-1.3.1.jar" "dom4j-1.5.2.jar" "ganymed-ssh2-build210.jar" "guava-13.0.1.jar" \
        "icu4j-4.8.1.1.jar" "mail-1.4.5.jar" "jaxen-1.1.3.jar" "jcommon-1.0.21.jar" "jdom-1.1.jar" "jfreechart-1.0.15.jar" "json-20090211.jar" "junixsocket-common-2.0.4.jar" \
        "junixsocket-demo-2.0.4.jar" "junixsocket-mysql-2.0.4.jar" "junixsocket-rmi-2.0.4.jar" "jzlib-1.0.7.jar" "libidn-1.24.jar" "log4j-1.2.16.jar" "mariadb-java-client-1.1.8.jar" "yuicompressor-2.4.2-zimbra.jar" \
        "spymemcached-2.9.1.jar"  "oauth-20100527.jar" "jtnef-1.9.0.jar" "unboundid-ldapsdk-2.3.5.jar" "xercesImpl-2.9.1.jar" "yuicompressor-2.4.2-zimbra.jar")
    for i in "${thirdpartyjars[@]}"
    do
        cp ${repoDir}/zm-zcs-lib/build/dist/${i} ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/common/lib
    done

    zimbrajars=("zm-common-*.jar" "zm-native-*.jar")
    for i in "${zimbrajars[@]}"
    do
        cp ${repoDir}/zm-zcs-lib/build/dist/${i} ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/common/lib
    done

   echo -e "\tCreate jetty conf" >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/etc
     mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/modules/npn
    cp -f ${repoDir}/zm-jetty-conf/conf/jetty/jettyrc  ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/etc/
    cp -f ${repoDir}/zm-jetty-conf/conf/jetty/zimbra.policy.example ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/etc/
    cp -f ${repoDir}/zm-jetty-conf/conf/jetty/jetty.xml.production ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/etc/jetty.xml.in
    cp -f ${repoDir}/zm-jetty-conf/conf/jetty/webdefault.xml.production ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/etc/webdefault.xml
    cp -f ${repoDir}/zm-jetty-conf/conf/jetty/jetty-setuid.xml ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/etc/jetty-setuid.xml
    cp -f ${repoDir}/zm-jetty-conf/conf/jetty/spnego/etc/spnego.properties ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/etc/spnego.properties.in
    cp -f ${repoDir}/zm-jetty-conf/conf/jetty/spnego/etc/spnego.conf ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/etc/spnego.conf.in
    cp -f ${repoDir}/zm-jetty-conf/conf/jetty/spnego/etc/krb5.ini ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/etc/krb5.ini.in
    cp -f ${repoDir}/zm-jetty-conf/conf/jetty/modules/*.mod  ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/modules
    cp -f ${repoDir}/zm-jetty-conf/conf/jetty/modules/*.mod.in ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/modules
    
    
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/start.d

    
    cp -f ${repoDir}/zm-jetty-conf/conf/jetty/start.d/*.ini.in   ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/start.d
    cp -f ${repoDir}/zm-jetty-conf/conf/jetty/modules/npn/*.mod  ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/modules/npn
    cp -f ${repoDir}/zm-store/conf/web.xml.production ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/etc/service.web.xml.in
    cp -f ${repoDir}/zm-web-client/WebRoot/WEB-INF/jetty-env.xml ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/etc/zimbra-jetty-env.xml.in
    cp -f ${repoDir}/zm-web-client/WebRoot/WEB-INF/jetty-env.xml ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/etc/zimbraAdmin-jetty-env.xml.in
    cp -f ${repoDir}/zm-zimlets/conf/web.xml.production ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/etc/zimlet.web.xml.in
    cat ${repoDir}/zm-web-client/WebRoot/WEB-INF/web.xml | \
        sed -e '/REDIRECTBEGIN/ s/$/ %%comment VAR:zimbraMailMode,-->,redirect%%/' \
        -e '/REDIRECTEND/ s/^/%%comment VAR:zimbraMailMode,<!--,redirect%% /' \
        > ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/etc/zimbra.web.xml.in
    cat ${repoDir}/zm-admin-console/WebRoot/WEB-INF/web.xml | \
        sed -e '/REDIRECTBEGIN/ s/$/ %%comment VAR:zimbraMailMode,-->,redirect%%/' \
        -e '/REDIRECTEND/ s/^/%%comment VAR:zimbraMailMode,<!--,redirect%% /' \
        > ${repoDir}/zm-build/${currentPackage}/opt/zimbra/${jettyVersion}/etc/zimbraAdmin.web.xml.in


    echo -e "\tCreate debian package" >> ${buildLogFile}
    (cd ${repoDir}/zm-build/${currentPackage}; find . -type f ! -regex '.*jetty-distribution-.*/webapps/zimbra/WEB-INF/jetty-env.xml' ! \
        -regex '.*jetty-distribution-.*/webapps/zimbraAdmin/WEB-INF/jetty-env.xml' ! -regex '.*jetty-distribution-.*/modules/setuid.mod' ! \
        -regex '.*jetty-distribution-.*/etc/krb5.ini' ! -regex '.*jetty-distribution-.*/etc/spnego.properties' ! -regex '.*jetty-distribution-.*/etc/jetty.xml' ! \
        -regex '.*jetty-distribution-.*/etc/spnego.conf' ! -regex '.*jetty-distribution-.*/webapps/zimbraAdmin/WEB-INF/web.xml' ! \
        -regex '.*jetty-distribution-.*/webapps/zimbra/WEB-INF/web.xml' ! -regex '.*jetty-distribution-.*/webapps/service/WEB-INF/web.xml' ! \
        -regex '.*jetty-distribution-.*/work/.*' ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -print0 | xargs -0 md5sum | \sed -e 's| \./| |' \
        > ${repoDir}/zm-build/${currentPackage}/DEBIAN/md5sums)
    cat ${repoDir}/zm-build/rpmconf/Spec/${currentScript}.deb | sed -e "s/@@VERSION@@/${release}.${buildNo}.${os/_/.}/" -e "s/@@branch@@/${buildTimeStamp}/" \
        -e "s/@@ARCH@@/${arch}/" -e "s/@@ARCH@@/amd64/" -e "s/^Copyright:/Copyright:/" -e "/^%post$/ r ${currentScript}.post" \
        > ${repoDir}/zm-build/${currentPackage}/DEBIAN/control
    (cd ${repoDir}/zm-build/${currentPackage}; dpkg -b ${repoDir}/zm-build/${currentPackage} ${repoDir}/zm-build/${arch})

    if [ $? -ne 0 ]; then
        echo -e "\t### ${currentPackage} package building failed ###" >> ${buildLogFile}
    else
        echo -e "\t*** ${currentPackage} package successfully created ***" >> ${buildLogFile}
    fi
