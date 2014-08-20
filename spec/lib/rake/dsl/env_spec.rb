require 'spec_helper'

describe Rake::DSL::Env do
  let(:dsl) { Class.new.extend Rake::DSL::Env }

  before do
    Rake::Configuration.reset!
  end

  describe 'setting and fetching variables' do
    before do
      dsl.set :scm, :git
    end

    context 'without a default' do
      context 'when the variables is defined' do
        it 'returns the variable' do
          expect(dsl.fetch(:scm)).to eq :git
        end
      end

      context 'when the variables is undefined' do
        it 'returns nil' do
          expect(dsl.fetch(:source_control)).to be_nil
        end
      end
    end

    context 'with a default' do
      context 'when the variables is defined' do
        it 'returns the variable' do
          expect(dsl.fetch(:scm, :svn)).to eq :git
        end
      end

      context 'when the variables is undefined' do
        it 'returns the default' do
          expect(dsl.fetch(:source_control, :svn)).to eq :svn
        end
      end
    end

    context 'with a block' do
      context 'when the variables is defined' do
        it 'returns the variable' do
          expect(dsl.fetch(:scm) { :svn }).to eq :git
        end
      end

      context 'when the variables is undefined' do
        it 'calls the block' do
          expect(dsl.fetch(:source_control) { :svn }).to eq :svn
        end
      end
    end

  end

  describe 'asking for a variable' do
    before do
      dsl.ask(:scm, :svn)
      $stdout.stubs(:print)
    end

    context 'variable is provided' do
      before do
        $stdin.expects(:gets).returns('git')
      end

      it 'sets the input as the variable' do
        expect(dsl.fetch(:scm)).to eq 'git'
      end
    end

    context 'variable is not provided' do
      before do
        $stdin.expects(:gets).returns('')
      end

      it 'sets the variable as the default' do
        expect(dsl.fetch(:scm)).to eq :svn
      end
    end
  end

  describe 'checking for presence' do
    subject { dsl.any? :linked_files }

    before do
      dsl.set(:linked_files, linked_files)
    end

    context 'variable is an non-empty array' do
      let(:linked_files) { %w{1} }

      it { should be true }
    end

    context 'variable is an empty array' do
      let(:linked_files) { [] }
      it { should be false }
    end

    context 'variable exists, is not an array' do
      let(:linked_files) { double }
      it { should be true }
    end

    context 'variable is nil' do
      let(:linked_files) { nil }
      it { should be false }
    end
  end
end
