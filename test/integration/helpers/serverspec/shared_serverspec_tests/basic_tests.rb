shared_examples 'basic suite' do
  # Windows
  describe file('C:\\Users\\vagrant\\google\\android-sdk'), if: os[:family] == 'windows' do
    it { should be_directory }
  end

  describe file('C:\\Users\\vagrant\\google\\android-sdk\\platform-tools\\adb.exe'), if: os[:family] == 'windows' do
    it { should exist }
  end

  describe command('adb kill-server'), if: os[:family] == 'windows' do
    its(:stderr) { should contain('server not running') }
  end

  # Unix
  describe command('adb kill-server'), if: os[:family] != 'windows' do
    its(:exit_status) { should eq 0 }
  end

  # All platform
  describe command('android -h') do
    its(:stdout) { should contain('android') }
  end
end
