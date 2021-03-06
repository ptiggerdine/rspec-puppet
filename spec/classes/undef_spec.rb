require 'spec_helper'

describe 'undef_test' do
  context "with required_attribute => 'some_string'" do
    context 'and defaults_to_undef unspecified' do
      let(:params) { { :required_attribute => 'some_string' } }

      it { should compile.with_all_deps }

      it { should contain_class('undef_test').with(:required_attribute => 'some_string') }

      it { should contain_class('undef_test').without_defaults_to_undef }

      it 'does not include undef parameters in the parameter count matcher' do
        res = catalogue.resource('Class', 'undef_test').to_hash.dup
        res.delete(:name)
        res.size.should eq(1)

        should contain_class('undef_test').only_with(
          :required_attribute => 'some_string',
          :defaults_to_undef  => nil
        )
      end
    end

    context 'and defaults_to_undef => :undef' do
      let(:params) { { :required_attribute => 'some_string', :defaults_to_undef => :undef } }

      it { should compile.with_all_deps }

      it { should contain_class('undef_test').with(:required_attribute => 'some_string') }

      it { should contain_class('undef_test').without_defaults_to_undef }

      it 'does not include undef parameters in the parameter count matcher' do
        res = catalogue.resource('Class', 'undef_test').to_hash.dup
        res.delete(:name)
        res.size.should eq(1)

        should contain_class('undef_test').only_with(
          :required_attribute => 'some_string',
          :defaults_to_undef  => nil
        )
      end
    end
  end

  context "with required_attribute => :undef", :unless => Puppet.version =~ /^2/ do
    context 'and defaults_to_undef unspecified' do
      let(:params) { { :required_attribute => :undef } }

      it { should compile.with_all_deps }

      it { should contain_class('undef_test').without_required_attribute }

      it { should contain_class('undef_test').without_defaults_to_undef }

      it 'does not include undef parameters in the parameter count matcher' do
        res = catalogue.resource('Class', 'undef_test').to_hash.dup
        res.delete(:name)
        res.size.should eq(0)

        should contain_class('undef_test').only_with(
          :required_attribute => nil,
          :defaults_to_undef  => nil
        )
      end
    end

    context 'and defaults_to_undef => :undef' do
      let(:params) { { :required_attribute => :undef, :defaults_to_undef => :undef } }

      it { should compile.with_all_deps }

      it { should contain_class('undef_test').without_required_attribute }

      it { should contain_class('undef_test').without_defaults_to_undef }

      it 'does not include undef parameters in the parameter count matcher' do
        res = catalogue.resource('Class', 'undef_test').to_hash.dup
        res.delete(:name)
        res.size.should eq(0)

        should contain_class('undef_test').only_with(
          :required_attribute => nil,
          :defaults_to_undef  => nil
        )
      end
    end
  end
end
