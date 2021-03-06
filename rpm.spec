Summary: Mozc for Amazon Linux 2
Name: albuild-ibus-mozc
Version: {{VERSION}}
Release: 0%{?dist}
Group: Applications/Editors
License: BSD-3-Clause
Source0: %{name}-%{version}.tar.gz
URL: https://github.com/albuild/mozc
BuildArch: x86_64
Requires: qt5-qtbase

%define installdir /opt/albuild-mozc/%{version}
%define builddir %{buildroot}%{installdir}

%description
A set of prebuilt Mozc binaries for Amazon Linux 2.

%install
files=(
  dataset_writer_main 
  gen_collocation_data_main
  gen_collocation_suppression_data_main
  gen_emoticon_rewriter_data_main
  gen_oss_sbm
  gen_single_kanji_noun_prefix_data_main
  gen_suggestion_filter_main
  gen_symbol_rewriter_dictionary_main
  gen_system_dictionary_data_main
  gen_usage_rewriter_dictionary_main
  ibus_mozc
  LICENSE
  mozc_renderer
  mozc_server
  mozc_tool
  mozc.xml
  protoc
)
rm -rf %{builddir}
mkdir -p %{builddir}
for f in "${files[@]}"; do
  cp /app/mozc/src/out_linux/Release/$f %{builddir}
done
cp /app/mozc/src/data/images/unix/ime_product_icon_opensource-32.png %{builddir}
mkdir -p %{buildroot}/usr/share/ibus/component
ln -sf /opt/albuild-mozc/${version}/mozc.xml %{buildroot}/usr/share/ibus/component/mozc.xml

%clean
rm -rf %{buildroot}

%files
%{installdir}
/usr/share/ibus/component/mozc.xml
