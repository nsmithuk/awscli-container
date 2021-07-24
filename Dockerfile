FROM ubuntu:20.04 as builder

COPY aws-cli.key ./

RUN apt-get update -y \
    && apt-get install -y curl unzip gpg \
    && gpg --import aws-cli.key \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip.sig" -o "awscliv2.sig" \
    && gpg --verify awscliv2.sig awscliv2.zip \
    && unzip -q awscliv2.zip \
    && ./aws/install


FROM ubuntu:20.04

ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends less groff \
    && apt-get -y autoremove \
    && apt-get -y autoclean

COPY --from=builder /usr/local/aws-cli /usr/local/aws-cli

RUN ln -s /usr/local/aws-cli/v2/current/bin/aws /usr/local/bin/aws \
    && ln -s /usr/local/aws-cli/v2/current/bin/aws_completer /usr/local/bin/aws_completer

CMD ["aws", "--version"]
