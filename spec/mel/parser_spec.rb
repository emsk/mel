RSpec.describe Mel::Parser do
  let(:parser) { described_class.new('') }

  describe '#on_def' do
    let(:method) { 'method1' }

    subject { -> { parser.on_def(method, args, nil) } }

    context 'given args' do
      let(:args) { %w[arg1 arg2] }
      it { is_expected.to output("def #{method}(#{args.join(', ')})\n").to_stdout }
    end

    context 'given no args' do
      let(:args) { nil }
      it { is_expected.to output("def #{method}\n").to_stdout }
    end
  end

  describe '#on_defs' do
    let(:target) { 'self' }
    let(:separator) { '.' }
    let(:method) { 'method1' }

    subject { -> { parser.on_defs(target, separator, method, args, nil) } }

    context 'given args' do
      let(:args) { %w[arg1 arg2] }
      it { is_expected.to output("#{target}#{separator}#{method}(#{args.join(', ')})\n").to_stdout }
    end

    context 'given no args' do
      let(:args) { nil }
      it { is_expected.to output("#{target}#{separator}#{method}\n").to_stdout }
    end
  end
end
