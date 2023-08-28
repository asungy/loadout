## GitHub Keys

### GPG key

A GPG key is needed to create a verified commit signature. To generate a key,
follow the steps in [this guide][github_generate_new_key] (as of commit
[55ced703][github_commit_55ced703], this is already set up with the appropriate
packages installed).

> When generating a GPG key, use the following information:
> - **username**: asungy
> - **email**: 62207329+asungy@users.noreply.github.com

#### Listing key IDs

Key IDs can be listed with the following command:

```bash
gpg --list-secret-keys
```

The output should look something like the following:

```
-------------------------------
sec   <mode> <date> [SC]
      <key ID>
uid                 [ultimate] <username> <email>
```

#### Add the public key to GitHub

To print the public key given a key ID, run the following:

```bash
gpg --armor --export <key ID>
```

#### Modify `home/programs/git/default.nix`

Git needs to be configured by Home Manager to use the newly generated GPG key.
Modify the `home/programs/git/default.nix` file and update the key in the
`signingConfig` object.

Don't forget to run `x home`.

#### Deleting keys

To delete the private key:
```
gpg --delete-secret-key [key ID]
```

To delete the public key:
```
gpg --delete-key [key ID]
```


[github_generate_new_key]: https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key
[github_commit_55ced703]: https://github.com/asungy/loadout/commit/55ced70398872e6f3aa83359216fcc7bc375965a
