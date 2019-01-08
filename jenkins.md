Jenkins
=======

## Table of Content

- [Windows Agent](#windows-agent)
- [Mac Agent](#mac-agent)
- [Parameterized Builds](#parameterized-builds)

## Windows Agent

1. The Jenkins server must be directly accessible from the internet without a proxy and a custom port fo JNLP (49187)

- Append the direct accessible public IP address of the Jenkins server to the file `/etc/default/jenkins`:

    ```
    JAVA_ARGS="-Djava.awt.headless=true -Dmail.smtp.starttls.enable=true -Dhudson.TcpSlaveAgentListener.hostName=xx.xx.xx.xx"
    ```

- Restart the jenkins service

    ```bash
    service jenkins restart
    ```

- Go to "Configure Global Security" in Jenkins and set "TCP port for JNLP agents" to "Fixed" with a custom port (49187)

- Go to "Manage Nodes" and add a new node with the following details:
    - Permanent Agent
    - Remote root directory: C:\jenkins
    - Labels: windows
    - Usage: Only build jobs with label expressions matching this node
    - Launch method: Launch agent via Java Web Start

- Open the details of the new node and download the launcher on the windows agent (Launch agent from browser), run the downloaded file and select "Install as Windows Service" in the wizard

- Install the following tools
    - [Git](https://git-scm.com/)
    - [Visual Studio Build Tools 2017](https://visualstudio.microsoft.com/)
    - [Visual Studio Test Agent 2017](https://visualstudio.microsoft.com/)
    - [nuget](https://www.nuget.org/)

- Edit the **Path** variable in the system environment variables and add the locations of the executables of the previous installed tools:

    ```
    C:\Program Files (x86)\Common Files\Oracle\Java\javapath;%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem;%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\;C:\Program Files\Amazon\cfn-bootstrap\;C:\Program Files\dotnet\;C:\Program Files\Git\cmd;C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin;C:\Program Files (x86)\Microsoft Visual Studio\2017\TestAgent\Common7\IDE;C:\Program Files (x86)\Microsoft Visual Studio\2017\TestAgent\Common7\IDE\CommonExtensions\Microsoft\TestWindow;C:\Program Files\nuget
    ```

- Restart the Jenkins agent service

- Reference the windows node in the Jenkinsfile so that the job gets build on the Windows agent.

    ```
    pipeline {
        agent {
            node {
                label 'windows'
            }
        }

        stages {
            ...
        }
    }
    ```

## Mac Agent

1. Install the following tools:
    - Xcode
    - [CocoaPods](https://cocoapods.org/)
    - [Android Studio](https://developer.android.com/studio/)
    - [Java Development Kit](https://www.java.com/)

- Create a Jenkins user on the Mac node (without administrator privileges)

- Allow the Jenkins user to connect using SSH (Settings -> Sharing -> Remote Login -> Only these users -> Add Jenkins user)

- Try to connect from the Jenkins server to the Mac node to accept the host key verification. Therefore, a simple ssh command to the Mac node should be performed and the initial question answered with "yes". It is important, that you are logged in as Jenkins user on the Jenkins server while performing the command.

    ```bash
    ssh jenkins@207.254.71.237
    ```

- Open the file `/etc/ssh/sshd_config` and adjust the following lines:

    ```
    PasswordAuthentication no
    ```

- Reload the SSH configuration:

    ```bash
    sudo launchctl unload /System/Library/LaunchDaemons/ssh.plist
    sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist
    ```

- Install gem dependencies:

    ```bash
    sudo gem install bundler
    ```

- Go to "Manage Nodes" and add a new node with the following details:
    - Permanent Agent
    - Remote root directory: /Users/jenkins/jenkins
    - Labels: mac
    - Usage: Only build jobs with label expressions matching this node
    - Launch method: Launch agent agents with SSH
    - Host: IP address of agent
    - Credentials: SSH Username with private key (Scope: System)
    - Environment variables:
        - **PATH**: /Library/Java/JavaVirtualMachines/jdk1.8.0_191.jdk/Contents/Home/bin:/usr/local/bin:$PATH
        - **LANG**: en_US.UTF-8
        - **LC_ALL**: en_US.UTF-8
        - **ANDROID_HOME**: /Users/jenkins/Library/Android/sdk

- Open Android Studio and install all dependencies.

## Parameterized Builds

1. Set all parameters in the Jenkinsfile

    ```groovy
    pipeline {
        agent any

        parameters {
            string(name: 'tag', defaultValue: '1.0.0', description: 'Tag')
            gitParameter name: 'branch', branchFilter: 'origin/(.*)', defaultValue: 'master', type: 'PT_BRANCH'
        }

        steps {}
    }
    ```

    **Note:** If you wish to choose a Git branch/tag, you have to install the `git-parameter` plugin.

2. Setup the Jenkins job.

    **Note:** If you wish to run a specific branch/tag, you first have to reference the branch with the Jenkinsfile directly for the initial run.

3. Execute the pipeline the first time even if Jenkins will not ask for the parameters. After one or two seconds stop the execution. Now Jenkins was able to read the Jenkinsfile and set up the parameters accordingly.

4. Finally, adjust the Jenkinsfile and all other parts with the parameters.

    ```groovy
    {
        agent any

        parameters {}

        stages {
            stage('Stage') {
                steps {
                    sh "echo ${params.TAG}"
                    sh "echo ${params.BRANCH}"
                }
            }
        }
    }
    ```

    **Note:** If you want to checkout a specific Git branch/tag, then you have to ajust the job settings an replace the value for the branch specifier from `*/master` to `${BRANCH}`.
