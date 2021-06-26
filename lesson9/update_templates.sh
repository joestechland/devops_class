#!/bin/bash
#
# Name of the script : update_templates.sh
# Created by Alessandro Borges; 08-Nov-2018
# This script replaces all endpoints and other info for domains
#   for ansible.cfg, build.yml and purge.yml
#

if [ $# -ne 5 ]
then
  echo "Usage ./update_templates.sh \$event_id \$domain_name \$username \$password \$PLAYBOOK_NAME"
  echo "        EXAMPLE ... e.g. ./update_templates.sh 20200602 ocuocictrng14 gitousupport 'Cloud8Du0lc9' SQL-FUND"
  exit
fi

event_id=${1}
domain_name=${2}
username=${3}
password=${4}
PLAYBOOK_NAME=${5}
current_dir="`pwd`"

# Check if PLAYBOOK exists
for i in $(ls -d ${current_dir}/*/); do echo ${i%%/}; done > /tmp/PLAYBOOK_NAME.tmp
if grep -o "$PLAYBOOK_NAME" /tmp/PLAYBOOK_NAME.tmp
then
    echo "Processing ..."
    sleep 1
    rm -rf /tmp/PLAYBOOK_NAME.tmp*
else
    echo "Playbook $PLAYBOOK_NAME not found"
    echo "Exiting script."
    echo ""
    sleep 1
    rm -rf /tmp/PLAYBOOK_NAME.tmp*
    exit 0
fi
#

# Load Endpoints
source ${current_dir}/idcs_domain_matrix_ansible.sh $domain_name

# Check if domain_name exists
if [ -f /tmp/domain_name.ERROR ]; then
    echo "Invalid Domain ID ..."
    echo "Exiting script."
    echo ""
    sleep 1
    rm -rf /tmp/domain_name.ERROR*
    exit 0
else
    echo "Processing ..."
    sleep 1
    rm -rf /tmp/domain_name.ERROR*
fi

# log variables
log_path=/tmp/$event_id
#lib_path=${current_dir}/../ansible_modules/OCIC

# Creating log_path
echo "Creating $log_path directory ..."
mkdir -p $log_path

# Creating test files
echo "Creating ansible.cfg, build.yml and purge.yml files for $PLAYBOOK_NAME ..."
full_path=${current_dir}/$PLAYBOOK_NAME
cp $full_path/ansible.cfg_template $full_path/ansible.cfg
cp $full_path/build.yml_template $full_path/build.yml
cp $full_path/purge.yml_template $full_path/purge.yml

# Replacing values in the ansible.cfg test file
echo "Replacing values in the ansible.cfg test file ..."
file_full_path=$full_path/ansible.cfg
sed -i -e "s|<log_path>|$log_path|g" $file_full_path
#sed -i -e "s|<lib_path>|$lib_path|g" $file_full_path
sed -i -e "s|<username>|$username|g" $file_full_path
sed -i -e "s|<password>|$password|g" $file_full_path
sed -i -e "s|<event_id>|$event_id|g" $file_full_path
sed -i -e "s|<domain_name>|$domain_name|g" $file_full_path
sed -i -e "s|<dbas>|$dbas|g" $file_full_path
sed -i -e "s|<jcs>|$jcs|g" $file_full_path
sed -i -e "s|<psm>|$psm|g" $file_full_path
sed -i -e "s|<storage-authv1>|$storageauthv1|g" $file_full_path
sed -i -e "s|<storage>|$storage|g" $file_full_path
sed -i -e "s|<IDCS_domain>|$IDCS_domain|g" $file_full_path
sed -i -e "s|<client_ID>|$client_ID|g" $file_full_path
sed -i -e "s|<secret>|$secret|g" $file_full_path
sed -i -e "s|<Tenancy_OCID>|$Tenancy_OCID|g" $file_full_path
sed -i -e "s|<User_OCID>|$User_OCID|g" $file_full_path
sed -i -e "s|<fingerprint>|$fingerprint|g" $file_full_path
sed -i -e "s|<key_file>|$key_file|g" $file_full_path
sed -i -e "s|<compute_SID>|$compute_SID|g" $file_full_path
#Variables needed for multiple instances env only - values set for testing purposes only
sed -i -e "s|<start_point>|1|g" $file_full_path
sed -i -e "s|<n_build>|5|g" $file_full_path
sed -i -e "s|<student_user>|ora001|g" $file_full_path
sed -i -e "s|<oci_student_user>|lab.user01|g" $file_full_path
sed -i -e "s|<oci_user>|lab.user01|g" $file_full_path
sed -i -e "s|<region>|us-ashburn-1|g" $file_full_path
sed -i -e "s|<availability_domain>|CPQY:US-ASHBURN-AD-1|g" $file_full_path

# Replacing values in the build.yml test file
echo "Replacing values in the build.yml test file ..."
file_full_path=$full_path/build.yml
sed -i -e "s|<log_path>|$log_path|g" $file_full_path
#sed -i -e "s|<lib_path>|$lib_path|g" $file_full_path
sed -i -e "s|<username>|$username|g" $file_full_path
sed -i -e "s|<password>|$password|g" $file_full_path
sed -i -e "s|<event_id>|$event_id|g" $file_full_path
sed -i -e "s|<domain_name>|$domain_name|g" $file_full_path
sed -i -e "s|<dbas>|$dbas|g" $file_full_path
sed -i -e "s|<jcs>|$jcs|g" $file_full_path
sed -i -e "s|<psm>|$psm|g" $file_full_path
sed -i -e "s|<storage-authv1>|$storageauthv1|g" $file_full_path
sed -i -e "s|<storage>|$storage|g" $file_full_path
sed -i -e "s|<IDCS_domain>|$IDCS_domain|g" $file_full_path
sed -i -e "s|<client_ID>|$client_ID|g" $file_full_path
sed -i -e "s|<secret>|$secret|g" $file_full_path
sed -i -e "s|<Tenancy_OCID>|$Tenancy_OCID|g" $file_full_path
sed -i -e "s|<User_OCID>|$User_OCID|g" $file_full_path
sed -i -e "s|<fingerprint>|$fingerprint|g" $file_full_path
sed -i -e "s|<key_file>|$key_file|g" $file_full_path
sed -i -e "s|<compute_SID>|$compute_SID|g" $file_full_path
#Variables needed for multiple instances env only - values set for testing purposes only
sed -i -e "s|<start_point>|1|g" $file_full_path
sed -i -e "s|<n_build>|5|g" $file_full_path
sed -i -e "s|<student_user>|ora001|g" $file_full_path
sed -i -e "s|<oci_student_user>|lab.user01|g" $file_full_path
sed -i -e "s|<oci_user>|lab.user01|g" $file_full_path
sed -i -e "s|<region>|us-ashburn-1|g" $file_full_path
sed -i -e "s|<availability_domain>|CPQY:US-ASHBURN-AD-1|g" $file_full_path

# Replacing values in the purge.yml test file
echo "Replacing values in the purge.yml test file ..."
file_full_path=$full_path/purge.yml
sed -i -e "s|<log_path>|$log_path|g" $file_full_path
#sed -i -e "s|<lib_path>|$lib_path|g" $file_full_path
sed -i -e "s|<username>|$username|g" $file_full_path
sed -i -e "s|<password>|$password|g" $file_full_path
sed -i -e "s|<event_id>|$event_id|g" $file_full_path
sed -i -e "s|<domain_name>|$domain_name|g" $file_full_path
sed -i -e "s|<dbas>|$dbas|g" $file_full_path
sed -i -e "s|<jcs>|$jcs|g" $file_full_path
sed -i -e "s|<psm>|$psm|g" $file_full_path
sed -i -e "s|<storage-authv1>|$storageauthv1|g" $file_full_path
sed -i -e "s|<storage>|$storage|g" $file_full_path
sed -i -e "s|<IDCS_domain>|$IDCS_domain|g" $file_full_path
sed -i -e "s|<client_ID>|$client_ID|g" $file_full_path
sed -i -e "s|<secret>|$secret|g" $file_full_path
sed -i -e "s|<Tenancy_OCID>|$Tenancy_OCID|g" $file_full_path
sed -i -e "s|<User_OCID>|$User_OCID|g" $file_full_path
sed -i -e "s|<fingerprint>|$fingerprint|g" $file_full_path
sed -i -e "s|<key_file>|$key_file|g" $file_full_path
sed -i -e "s|<compute_SID>|$compute_SID|g" $file_full_path
#Variables needed for multiple instances env only - values set for testing purposes only
sed -i -e "s|<start_point>|1|g" $file_full_path
sed -i -e "s|<n_build>|5|g" $file_full_path
sed -i -e "s|<student_user>|ora001|g" $file_full_path
sed -i -e "s|<oci_student_user>|lab.user01|g" $file_full_path
sed -i -e "s|<oci_user>|lab.user01|g" $file_full_path
sed -i -e "s|<region>|us-ashburn-1|g" $file_full_path
sed -i -e "s|<availability_domain>|CPQY:US-ASHBURN-AD-1|g" $file_full_path

# Final Msg
echo " ######################################### "
echo ""
echo "Done! Please double check ansible.cfg, build.yml and purge.yml for playbook $PLAYBOOK_NAME before running tests"
echo " if all good, then you can run your tests/playbooks for $PLAYBOOK_NAME"
echo "  All logs and other files will be generated in $log_path/"
echo ""
echo " When you are all set with the tests, please remove the following: "
echo "   $full_path/ansible.cfg "
echo "   $full_path/build.yml "
echo "   $full_path/purge.yml "
echo "   $log_path/"
echo ""
echo " ######################################### "
echo ""

